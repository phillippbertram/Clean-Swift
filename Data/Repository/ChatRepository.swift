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
    private(set) var dataSubject: BehaviorSubject<[String: Chat]> = BehaviorSubject(value: [:])

    public init() {
        let contact = Contact(userName: "alb", firstName: "Alexander", lastName: "Brechmann")
        let chat = Chat(id: UUID().uuidString,
                        participant: contact,
                        lastMessage: nil,
                        lastModifiedAt: Date(),
                        createdAt: Date())
        addChat(chat)
    }

    fileprivate func addChat(_ chat: Chat) {
        data[chat.id] = chat
        dataSubject.onNext(data)
    }

}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func observeAll() -> Observable<[Chat]> {
        return dataSubject.asObserver().map({ Array($0.values) })
    }

    public func create(chat: Chat) -> Observable<Chat> {
        return Observable.deferred {
            self.addChat(chat)
            return Observable.just(chat)
        }
    }

    public func get(byId chatId: String) -> Observable<Chat> {
        return Observable.deferred {
            if let chat = self.data[chatId] {
                return Observable.just(chat)
            }
            return Observable.error(ChatRepositoryError.chatNotFound(id: chatId))
        }
    }

    public func getAll() -> Observable<[Chat]> {
        return Observable.deferred {
            return Observable.just(Array(self.data.values))
        }
    }

}
