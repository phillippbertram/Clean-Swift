//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import Common
import RxSwift

public final class MessageDataSourceDb {

    fileprivate let messageMapper = MessageEntityDomainMapper()

    fileprivate let messageDao: MessageDAO
    fileprivate let sessionManager: SessionManager

    public init(messageDao: MessageDAO, sessionManager: SessionManager) {
        self.messageDao = messageDao
        self.sessionManager = sessionManager
    }

    public func persist(messages: [Message]) {

    }

    public func `import`(apiMessages: [ApiMessage]) -> Single<[Message]> {
        return messageDao.write { [unowned self] realm -> [MessageEntity] in
                    return apiMessages.map { apiMessage in
                        if let existingMessage = self.messageDao.find(realm: realm, byRemoteId: apiMessage.id) {
                            existingMessage.remoteId = apiMessage.id
                            existingMessage.message = apiMessage.content
                        }
                        notImplemented()
                    }
                }
                .map { [unowned self] in
                    self.messageMapper.mapAll($0)
                }
    }

}

// MARK: - MessageDataSource

extension MessageDataSourceDb: MessageDataSource {

    public func getAll(for chat: Chat) -> Single<[Message]> {
        return Single.deferred { [unowned self] in
                    let messageEntities = self.messageDao.findAll(forChat: chat.id)
                    return Single.just(messageEntities)
                }
                .map { [unowned self] in
                    self.messageMapper.mapAll($0)
                }
    }

    public func find(byRemoteId remoteId: String) -> Single<Message> {
        return Single.deferred { [unowned self] in
                    guard let entity = self.messageDao.find(byRemoteId: remoteId) else {
                        return Single.error(DataSourceError.messageNotFound)
                    }
                    return Single.just(entity)
                }
                .map(messageMapper.map)
    }

    public func observeAll(for chat: Chat) -> Observable<[Message]> {
        return Observable.deferred { [unowned self] () -> Observable<[MessageEntity]> in
                    return self.messageDao.observe(forChat: chat.id)
                }
                .map { [unowned self] in
                    self.messageMapper.mapAll($0)
                }
    }

}
