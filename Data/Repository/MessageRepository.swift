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

    public func getAll(for chat: Chat) -> Single<[Message]> {
        return observeAll(for: chat).asSingle()
    }

    public func find(byRemoteId remoteId: String) -> Single<Message> {
        return Single.deferred { [unowned self] in
                    guard let entity = self.messageDAO.find(byRemoteId: remoteId) else {
                        return Single.error(MessageRepositoryError.messageNotFound)
                    }
                    return Single.just(entity)
                }
                .map(messageMapper.map)
    }

    public func observeAll(for chat: Chat) -> Observable<[Message]> {
        return Observable.deferred { [unowned self] () -> Observable<[MessageEntity]> in
            return self.messageDAO.observe(forChat: chat.id)
        }.map(self.messageMapper.mapAll)
    }

    public func create(message: CreateMessageParam) -> Single<Message> {
        return Observable.deferred { [unowned self] in
                    return self.messageDAO.write { () -> MessageEntity in

                        guard let chatEntity = self.chatDAO.find(byPrimaryKey: message.chatId) else {
                            throw MessageRepositoryError.chatNotFound
                        }

                        let entity = MessageEntity(senderId: message.sender.userName, chat: chatEntity)
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
                .asSingle()
    }

    public func updateAll(_ messages: [Message]) -> Single<[Message]> {
        // TODO: implement me
        fatalError()
    }

    public func update(message: Message) -> Single<Message> {
        return Observable.deferred { [unowned self] in
            return self.messageDAO.update(primaryKey: message.id) { messageEntity in
                messageEntity.status = MessageEntity.Status.from(message.status)
                messageEntity.isIncoming = message.isIncoming
                messageEntity.isRead = message.isRead
                messageEntity.message = message.content.text ?? ""
                return messageEntity
            }
        }.map { [unowned self] in
            self.messageMapper.map($0)
        }.asSingle()
    }

    public func delete(message: Message) -> Completable {
        return Completable.deferred { [unowned self] in
            do {
                try self.messageDAO.delete(byId: message.id)
            } catch {
                log.error("Could not delete Message: \(message)")
            }
            return Completable.empty()
        }
    }

    public func getAllUnSynced() -> Single<[Message]> {
        return Single.deferred { [unowned self] in
            let messages = self.messageDAO.find { entity in
                switch entity.status {
                    case .sent, .delivered:
                        return false
                    case .sending, .failed:
                        return true
                }
            }
            return Single.just(messages)
        }.map { [unowned self] in
            self.messageMapper.mapAll($0)
        }
    }

}
