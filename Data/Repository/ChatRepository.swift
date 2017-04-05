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
    private(set) var dataSubject: PublishSubject<[String: Chat]> = PublishSubject()

    public init() {

    }

}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func observeAllChats() -> Observable<[Chat]> {
        return dataSubject.asObserver().map({ Array($0.values) })
    }

    public func create(chat: Chat) -> Observable<Chat> {
        return Observable.deferred {
            self.data[chat.id] = chat
            self.dataSubject.onNext(self.data)
            return Observable.just(chat)
        }
    }

    public func getChat(withId chatId: String) -> Observable<Chat> {
        return Observable.deferred {
            if let chat = self.data[chatId] {
                return Observable.just(chat)
            }
            return Observable.error(ChatRepositoryError.chatNotFound(id: chatId))
        }
    }

    public func getAllChats() -> Observable<[Chat]> {
        return Observable.deferred {
            return Observable.just(Array(self.data.values))
        }
    }

}
