//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import Common
import RxSwift

public final class ChatDataSourceLocal {

    fileprivate let chatMapper = ChatEntityDomainMapper()

    fileprivate let chatDao: ChatDAO

    public init(chatDao: ChatDAO) {
        self.chatDao = chatDao
    }

}

// MARK: Public

extension ChatDataSourceLocal {

    public func importFromApi(_ apiChats: [ApiChat]) -> Single<[Chat]> {
        // TODO: implement me
        return Single.error(GeneralError.notImplemented)
    }

    public func persist(chat: CreateChatParam) -> Single<Chat> {
        return Observable.deferred { [unowned self] in
                    return self.chatDao.write { () -> ChatEntity in
                        let contact = chat.participant
                        let contactEntity = ContactEntity()
                        contactEntity.id = contact.userName
                        contactEntity.firstName = contact.firstName
                        contactEntity.lastName = contact.lastName
                        let chatEntity = ChatEntity(participant: contactEntity)
                        return chatEntity
                    }
                }
                .map { [unowned self] in
                    self.chatMapper.map($0)
                }
                .asSingle()
    }

    func observeAll() -> Observable<[Chat]> {
        return chatDao
                .observeAll()
                .map { [unowned self] in
                    self.chatMapper.mapAll($0)
                }
    }

    func get(forContact contact: Contact) -> Single<Chat> {
        return getAll()
                .map { chats in
                    guard let chat = chats.filter({ $0.participant == contact }).first else {
                        throw DataSourceError.chatNotFound
                    }
                    return chat
                }
    }

    public func delete(chat: Chat) -> Completable {
        return Completable.deferred { [unowned self] in
            do {
                try self.chatDao.delete(byId: chat.id)
            } catch (let error) {
                log.error("Could not delete Chat [\(chat)]. Error: \(error)")
                throw DataSourceError.failedDeletingChat
            }
            return Completable.empty()
        }
    }

}

// MARK: ChatDataSource

extension ChatDataSourceLocal: ChatDataSource {

    func getAll() -> Single<[Chat]> {
        return Single.deferred { [unowned self] in
                    let entities = self.chatDao.findAll()
                    return Single.just(entities)
                }
                .map { [unowned self] in
                    self.chatMapper.mapAll($0)
                }
    }

    func get(byId chatId: String) -> Single<Chat> {
        return Single.deferred { [unowned self] () -> Single<ChatEntity> in
            guard let chat = self.chatDao.find(byPrimaryKey: chatId) else {
                return Single.error(DataSourceError.chatNotFound)

            }
            return Single.just(chat)
        }.map(chatMapper.map)
    }

}
