//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class MessageRepository {

    fileprivate let messageMapper = MessageEntityDomainMapper()

    fileprivate let messageDAO: MessageDAO

    public init(messageDAO: MessageDAO) {
        self.messageDAO = messageDAO
    }

}

// MARK: - MessageRepositoryType

extension MessageRepository: MessageRepositoryType {

    public func getAll(for chat: Chat) -> Observable<[Message]> {
        return Observable.deferred { [unowned self] () -> Observable<[MessageEntity]> in

            guard let chatId = chat.id else {
                return Observable.just([])
            }

            let messageEntities = self.messageDAO.find { messageEntity in
                messageEntity.chat.id == chatId
            }
            return Observable.just(messageEntities)
        }.map(self.messageMapper.mapAll)
    }

    public func create(text: String, sender: Contact, chat: Chat, status: Message.Status) -> Observable<Message> {
        fatalError()
    }

    public func createMessage(_ message: Message) -> Observable<Message> {
        fatalError()
    }

    public func updateAll(_ messages: [Message]) -> Observable<[Message]> {
        fatalError()
    }

    public func update(message: Message) -> Observable<Message> {
        fatalError()
    }

    public func delete(message: Message) -> Observable<Void> {
        fatalError()
    }

}
