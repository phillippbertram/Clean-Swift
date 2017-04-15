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
        return Observable.just([])
    }

    public func create(chat: Chat) -> Observable<Chat> {
        fatalError()
    }

    public func get(byId chatId: String) -> Observable<Chat> {
        return Observable.deferred { [unowned self] () -> Observable<ChatEntity> in
            guard let chat = self.chatDao.find(byPrimaryKey: chatId) else {
                return Observable.error(ChatRepositoryError.chatNotFound)

            }

            return Observable.just(chat)
        }.map(chatMapper.map)
    }

    public func get(forContact contact: Contact) -> Observable<Chat> {
        return getAll()
                .map { chats in
                    guard let chat = chats.filter({ $0.participant == contact }).first else {
                        throw ChatRepositoryError.chatNotFound
                    }
                    return chat
                }
    }

    public func getAll() -> Observable<[Chat]> {
        return Observable.deferred { [unowned self] in
            let entities = self.chatDao.findAll()
            return Observable.just(entities)
        }.map(chatMapper.mapAll)
    }

}
