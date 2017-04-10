//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class MessageRepository {

    fileprivate var data: [String: Message] = [:]
    fileprivate let messageService: MessageServiceType

    public init(messageService: MessageServiceType) {
        self.messageService = messageService
    }

    fileprivate func addMessage(_ message: Message) {
        data[message.id] = message
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

    public func create(text: String, sender: Contact, chat: Chat, status: Message.Status) -> Observable<Message> {
        return Observable.deferred {
            let id = UUID().uuidString
            let message = Message(id: id,
                                  chatId: chat.id,
                                  content: .text(text),
                                  status: status,
                                  sender: sender,
                                  isIncoming: false,
                                  isRead: true,
                                  timestamp: Date(),
                                  lastModifiedAt: Date())
            return Observable.just(message)
        }
        .flatMap(createMessage)
    }

    public func createMessage(_ message: Message) -> Observable<Message> {
        return Observable.deferred {
            self.addMessage(message)
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

    public func delete(message: Message) -> Observable<Void> {
        return Observable.deferred {
            _ = self.data.removeValue(forKey: message.id)
            return Observable.empty()
        }
    }

}
