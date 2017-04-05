//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class MessageRepository {

    fileprivate var data: [String: Message] = [:]

    public init() {

    }

}

// MARK: - MessageRepositoryType

extension MessageRepository: MessageRepositoryType {

    public func getAll(for chat: Chat) -> Observable<[Message]> {
        return Observable.deferred {
            let messages = self.data.values.filter { message in
                message.chatId == chat.id
            }
            return Observable.just(Array(messages))
        }
    }

    public func create(message: String, sender: Contact, chat: Chat, status: Message.Status) -> Observable<Message> {
        return Observable.deferred {
            let id = UUID().uuidString
            let message = Message(id: id,
                                  chatId: chat.id,
                                  content: .text(message),
                                  status: status,
                                  sender: sender,
                                  isIncoming: false,
                                  isRead: true,
                                  timestamp: Date(),
                                  lastModifiedAt: Date())
            return Observable.just(message)
        }
    }

    public func updateAll(_ messages: [Message]) -> Observable<[Message]> {
        return Observable.deferred {
            var updatedMessages: [Message] = []
            for message in messages {
                var modifiedMessage = message
                modifiedMessage.lastModifiedAt = Date()
                self.data[message.id] = modifiedMessage
                updatedMessages.append(modifiedMessage)
            }
            return Observable.just(updatedMessages)
        }
    }

    public func update(message: Message) -> Observable<Message> {
        return Observable.deferred {
            var modifiedMessage = message
            modifiedMessage.lastModifiedAt = Date()
            self.data[message.id] = modifiedMessage
            return Observable.just(modifiedMessage)
        }
    }

}
