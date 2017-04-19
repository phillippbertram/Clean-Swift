//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ChatRepository {

    fileprivate let chatMapper = ChatEntityDomainMapper()

    fileprivate let chatDao: ChatDAO

    public init(chatDao: ChatDAO) {
        self.chatDao = chatDao
    }
}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func observeAll() -> Observable<[Chat]> {
        return chatDao.observeAll().map { [unowned self] chatEntities in
            self.chatMapper.mapAll(chatEntities)
        }
    }

    public func create(chat: CreateChatParam) -> Single<Chat> {
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

    public func get(byId chatId: String) -> Single<Chat> {
        return Single.deferred { [unowned self] () -> Single<ChatEntity> in
            guard let chat = self.chatDao.find(byPrimaryKey: chatId) else {
                return Single.error(ChatRepositoryError.chatNotFound)

            }

            return Single.just(chat)
        }.map(chatMapper.map)
    }

    public func get(forContact contact: Contact) -> Single<Chat> {
        return getAll()
                .map { chats in
                    guard let chat = chats.filter({ $0.participant == contact }).first else {
                        throw ChatRepositoryError.chatNotFound
                    }
                    return chat
                }
    }

    public func getAll() -> Single<[Chat]> {
        return Single.deferred { [unowned self] in
            let entities = self.chatDao.findAll()
            return Single.just(entities)
        }.map(chatMapper.mapAll)
    }

    // MARK: Deleting

    public func delete(chat: Chat) -> Completable {
        return Completable.deferred { [unowned self] in
            do {
                try self.chatDao.delete(byId: chat.id)
            } catch {
                log.error("Could not delete Chat: \(chat)")
            }
            return Completable.empty()
        }
    }

}
