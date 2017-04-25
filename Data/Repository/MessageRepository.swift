//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import Common
import RxSwift

public final class MessageRepository {

    fileprivate let localDataSource: MessageDataSourceLocal
    fileprivate let messageApi: MessageApiType

    public init(localDataSource: MessageDataSourceLocal,
                messageApi: MessageApiType) {
        self.localDataSource = localDataSource
        self.messageApi = messageApi
    }

}

// MARK: - MessageRepositoryType

extension MessageRepository: MessageRepositoryType {

    public func send(message: Message, receiver: String) -> Single<Message> {
        return Single.deferred { [unowned self] () -> Single<ApiMessage> in
            let request = ApiMessageRequest()
            return self.messageApi.send(message: request, receiver: receiver)
        }.map { _ in
            // TODO: return update message
            return message
        }
    }

    public func getAll(for chat: Chat) -> Single<[Message]> {
        return localDataSource.getAll(for: chat)
    }

    public func find(byRemoteId remoteId: String) -> Single<Message> {
        return localDataSource.find(byRemoteId: remoteId)
    }

    public func observeAll(for chat: Chat) -> Observable<[Message]> {
        return localDataSource.observeAll(for: chat)
    }

    public func create(message: CreateMessageParam) -> Single<Message> {
        // TODO: implement me
        return Single.error(GeneralError.notImplemented)
//        return Observable.deferred { [unowned self] in
//                    return self.messageDAO.write { () -> MessageEntity in
//
//                        guard let chatEntity = self.chatDAO.find(byPrimaryKey: message.chatId) else {
//                            throw MessageRepositoryError.chatNotFound
//                        }
//
//                        let entity = MessageEntity(senderId: message.sender.userName, chat: chatEntity)
//                        entity.isIncoming = message.isIncoming
//                        entity.isRead = message.isRead
//                        entity.status = MessageEntity.Status.from(message.status)
//                        entity.message = message.content.text ?? ""
//                        return entity
//                    }
//                }
//                .map { [unowned self] in
//                    self.messageMapper.map($0)
//                }
//                .asSingle()
    }

    public func updateAll(_ messages: [Message]) -> Single<[Message]> {
        // TODO: implement me
        return Single.error(GeneralError.notImplemented)
    }

    public func update(message: Message) -> Single<Message> {
        // TODO: implement me
        return Single.error(GeneralError.notImplemented)
//        return Observable.deferred { [unowned self] in
//                    return self.messageDAO.update(primaryKey: message.id) { messageEntity in
//                        messageEntity.status = MessageEntity.Status.from(message.status)
//                        messageEntity.isIncoming = message.isIncoming
//                        messageEntity.isRead = message.isRead
//                        messageEntity.message = message.content.text ?? ""
//                        return messageEntity
//                    }
//                }
//                .map { [unowned self] in
//                    self.messageMapper.map($0)
//                }
//                .asSingle()
    }

    public func delete(message: Message) -> Completable {
        // TODO: implement me
        return Completable.error(GeneralError.notImplemented)
//        return Completable.deferred { [unowned self] in
//            do {
//                try self.messageDAO.delete(byId: message.id)
//            } catch {
//                log.error("Could not delete Message: \(message)")
//            }
//            return Completable.empty()
//        }
    }

}
