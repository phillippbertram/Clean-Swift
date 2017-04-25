//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class MessageDataSourceLocal {

    fileprivate let messageMapper = MessageEntityDomainMapper()

    fileprivate let messageDao: MessageDAO

    public init(messageDao: MessageDAO) {
        self.messageDao = messageDao
    }

}

// MARK: - MessageDataSource

extension MessageDataSourceLocal: MessageDataSource {

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
