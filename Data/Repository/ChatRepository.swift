//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class ChatRepository {

    fileprivate var data: [String: Chat] = [:]

    public init() {

    }

}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func getAllChats() -> Observable<[Chat]> {
        return Observable.just(Array(data.values))
    }

    public func create(chat: Chat) -> Observable<Chat> {
        return Observable.deferred {
            self.data[chat.id] = chat
            return Observable.just(chat)
        }
    }

    public func findChat(withId chatId: String) -> Observable<Chat> {
        return Observable.deferred {
            if let chat = self.data[chatId] {
                return Observable.just(chat)
            }
            return Observable.error(ChatRepositoryError.chatNotFound(id: chatId))
        }
    }


}
