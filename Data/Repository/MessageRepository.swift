//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class MessageRepository {

    fileprivate let messageMapper = MessageEntityDomainMapper()

    fileprivate let messageDAO: MessageDAO
    fileprivate let contactDAO: ContactDAO
    fileprivate let chatDAO: ChatDAO

    public init(messageDAO: MessageDAO, contactDAO: ContactDAO, chatDAO: ChatDAO) {
        self.messageDAO = messageDAO
        self.contactDAO = contactDAO
        self.chatDAO = chatDAO
    }

}

// MARK: - MessageRepositoryType

extension MessageRepository: MessageRepositoryType {

    public func getAll(for chat: Chat) -> Observable<[Message]> {
        return observeAll(for: chat).take(1)
    }

    public func observeAll(for chat: Chat) -> Observable<[Message]> {
        return Observable.deferred { [unowned self] () -> Observable<[MessageEntity]> in
            return self.messageDAO.observe(forChat: chat.id)
        }.map(self.messageMapper.mapAll)
    }

    public func create(message: CreateMessageParam) -> Observable<Message> {
        return Observable.deferred {
                    return self.messageDAO.write { () -> MessageEntity in

                        guard let senderEntity = self.contactDAO.find(byUserName: message.sender.userName) else {
                            throw MessageRepositoryError.contactNotFound
                        }

                        guard let chatEntity = self.chatDAO.find(byPrimaryKey: message.chatId) else {
                            throw MessageRepositoryError.chatNotFound
                        }

                        let entity = MessageEntity(sender: senderEntity, chat: chatEntity)
                        entity.isIncoming = message.isIncoming
                        entity.isRead = message.isRead
                        entity.status = MessageEntity.Status.from(message.status)
                        entity.message = message.content.text ?? ""
                        return entity
                    }
                }
                .map { [unowned self] in
                    self.messageMapper.map($0)
                }
    }

    public func updateAll(_ messages: [Message]) -> Observable<[Message]> {
        // TODO: implement me
        fatalError()
    }

    public func update(message: Message) -> Observable<Message> {
        // TODO: implement me
        fatalError()
    }

    public func delete(message: Message) -> Observable<Void> {
        return Observable.deferred { [unowned self] in
            do {
                try self.messageDAO.delete(byId: message.id)
            } catch {
                log.error("Could not delete Message: \(message)")
            }
            return Observable.just(())
        }
    }

}
