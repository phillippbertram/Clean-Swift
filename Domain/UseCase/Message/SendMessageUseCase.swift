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

public enum MessageResult {
    case sending(progress: Double)
}

public final class SendMessageUseCase: SingleUseCase<SendMessageUseCaseParams, MessageResult> {

    private let messageRepository: MessageRepositoryType
    private let messageService: MessageServiceType
    private let currentUserRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                messageRepository: MessageRepositoryType,
                messageService: MessageServiceType,
                currentUserRepository: AccountRepositoryType) {
        self.messageRepository = messageRepository
        self.messageService = messageService
        self.currentUserRepository = currentUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: SendMessageUseCaseParams) -> Single<MessageResult> {
        return currentUserRepository
                .getCurrentUser()
                .map({ ($0, params.chat) })
                .flatMap { [unowned self] (currentUser, chat) -> Single<Message> in
                    let param = CreateMessageParam(chatId: params.chat.id,
                                                   content: .text(params.messageText),
                                                   status: .sending,
                                                   sender: currentUser.asContact(),
                                                   isIncoming: false,
                                                   isRead: true,
                                                   timestamp: Date())

                    return self.messageRepository
                            .create(message: param)
                }
                .flatMap { [unowned self] message in
                    return self.messageService
                            .send(message: message, toContact: params.chat.participant.userName)
                            .catchError { [unowned self] error in
                                return self.handleError(error, forMessage: message)
                            }
                }
                .map({ _ in MessageResult.sending(progress: 1) })
    }

    private func handleError(_ error: Error, forMessage message: Message) -> Single<Message> {
        var modifiedMessage = message
        modifiedMessage.status = .failure
        return messageRepository.update(message: modifiedMessage)
    }

}
