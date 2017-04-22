//
// Created by Phillipp Bertram on 20.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ImportApiMessagesUseCase: SingleUseCase<[MessageDTO], [Message]> {

    fileprivate let messageRepository: MessageRepositoryType
    fileprivate let contactRepository: ContactRepositoryType
    fileprivate let accountRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                messageRepository: MessageRepositoryType,
                contactRepository: ContactRepositoryType,
                accountRepository: AccountRepositoryType) {
        self.messageRepository = messageRepository
        self.contactRepository = contactRepository
        self.accountRepository = accountRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: [MessageDTO]) -> Single<[Message]> {
        return Observable
                .from(params)
                .flatMap { [unowned self] messageDTO in
                    self.createOrUpdateMessage(for: messageDTO)
                }
                .toArray()
                .asSingle()
    }
}

// MARK: Helper

fileprivate extension ImportApiMessagesUseCase {

    fileprivate func createOrUpdateMessage(for dto: MessageDTO) -> Single<Message> {
        return messageRepository
                .find(byRemoteId: dto.id)
                .catchError { [unowned self] error in
                    if case MessageRepositoryError.messageNotFound = error {
                        return self.createMessage(messageDTO: dto)
                    }
                    return Single.error(error)
                }
                .flatMap { [unowned self] in
                    return self.updateMessage($0, withDTO: dto)
                }
    }

    fileprivate func createMessage(messageDTO: MessageDTO) -> Single<Message> {
        return accountRepository
                .getCurrentUser()
                .flatMap { [unowned self] currentUser in

                    // TODO: get remote chat
                    // TODO: get remote sender

                    var sender: Contact!
                    let isIncoming = messageDTO.sender != currentUser.userName

                    let param = CreateMessageParam(chatId: messageDTO.chatId,
                                                   remoteId: messageDTO.id,
                                                   content: .text(messageDTO.content),
                                                   status: Message.Status(status: messageDTO.messageStatus),
                                                   sender: sender,
                                                   isIncoming: isIncoming,
                                                   isRead: !isIncoming,
                                                   timestamp: messageDTO.timestamp)

                    return self.messageRepository.create(message: param)
                }
    }

    fileprivate func updateMessage(_ message: Message, withDTO dto: MessageDTO) -> Single<Message> {
        return Single.deferred { [unowned self] in
            var mutableMessage = message
            mutableMessage.timestamp = dto.timestamp
            mutableMessage.status = Message.Status(status: dto.messageStatus)
            mutableMessage.content = .text(dto.content)
            return self.messageRepository.update(message: mutableMessage)
        }
    }

}
