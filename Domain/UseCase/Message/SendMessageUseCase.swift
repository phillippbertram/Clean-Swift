//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public struct SendMessageUseCaseParams {

    let chat: Chat
    let messageText: String

    public static func from(chat: Chat, messageText: String) -> SendMessageUseCaseParams {
        return SendMessageUseCaseParams(chat: chat, messageText: messageText)
    }

}

public enum SendMessageUseCaseError: Error {
    case emptyMessage
}

public final class SendMessageUseCase: SingleUseCase<SendMessageUseCaseParams, Message> {

    fileprivate let messageService: MessageServiceType
    fileprivate let accountRepository: AccountRepositoryType
    fileprivate let messageRepository: MessageRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                accountRepository: AccountRepositoryType,
                messageRepository: MessageRepositoryType,
                messageAPI: MessageServiceType) {
        self.messageService = messageAPI
        self.accountRepository = accountRepository
        self.messageRepository = messageRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: SendMessageUseCaseParams) -> Single<Message> {
        return Single.deferred { [unowned self] in

            guard !params.messageText.isEmpty else {
                throw SendMessageUseCaseError.emptyMessage
            }

            return self.createMessage(params: params)
                .flatMap { [unowned self] in
                    self.sendMessage($0, receiver: params.chat.participant.userName)
            }
        }
    }
}

// MARK: Helper

fileprivate extension SendMessageUseCase {

    fileprivate func createMessage(params: SendMessageUseCaseParams) -> Single<Message> {
        return accountRepository
                .getCurrentUser()
                .map({ ($0, params.chat) })
                .flatMap { [unowned self] (currentUser, chat) -> Single<Message> in
                    let param = CreateMessageParam(chatId: params.chat.id,
                                                   remoteId: nil,
                                                   content: .text(params.messageText),
                                                   status: .sending,
                                                   sender: currentUser.asContact(),
                                                   isIncoming: false,
                                                   isRead: true,
                                                   timestamp: Date())

                    return self.messageRepository
                            .create(message: param)
                }
    }

    fileprivate func sendMessage(_ message: Message, receiver: String) -> Single<Message> {
        let messageRequest = MessageRequestDTO()
        return messageService
                .send(message: messageRequest, receiver: receiver)
                .flatMap { [unowned self] messageDTO -> Single<Message> in
                    log.debug("successfully sent message with result: \(messageDTO)")
                    var modifiedMessage = message
                    modifiedMessage.status = .sent
                    // TODO: import messageDTO?
                    return self.messageRepository.update(message: modifiedMessage)
                }
                .catchError { [unowned self] error -> Single<Message> in
                    return self.handleError(error, forMessage: message)
                }
    }

    fileprivate func handleError(_ error: Error, forMessage message: Message) -> Single<Message> {
        var modifiedMessage = message
        modifiedMessage.status = .failure
        return messageRepository.update(message: modifiedMessage)
    }

}
