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

public final class SendMessageUseCase: UseCase<SendMessageUseCaseParams, MessageResult> {

    private let createChatUseCase: CreateChatForContactUseCase
    private let messageRepository: MessageRepositoryType
    private let messageService: MessageServiceType
    private let currentUserRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                createChatUseCase: CreateChatForContactUseCase,
                messageRepository: MessageRepositoryType,
                messageService: MessageServiceType,
                currentUserRepository: AccountRepositoryType) {

        self.createChatUseCase = createChatUseCase
        self.messageRepository = messageRepository
        self.messageService = messageService
        self.currentUserRepository = currentUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: SendMessageUseCaseParams) -> Observable<MessageResult> {
        return createChatUseCase
                .build(params.chat.participant)
                .flatMap { [unowned self] chat in
                    self.currentUserRepository.getCurrentUser().map({ ($0, chat) })
                }
                .flatMap { (currentUser, chat) in
                    self.messageRepository
                            .create(text: params.messageText,
                                    sender: currentUser.asContact(),
                                    chat: chat,
                                    status: .sending)
                }
                .flatMap { message in
                    return self.messageService
                            .send(message: message, toContact: params.chat.participant.userName)
                            .catchError { error in
                                return self.handleError(error, forMessage: message)
                            }
                }
                .map({ _ in MessageResult.sending(progress: 1) })
    }

    private func handleError(_ error: Error, forMessage message: Message) -> Observable<Message> {
        var modifiedMessage = message
        modifiedMessage.status = .failure
        return messageRepository.update(message: modifiedMessage)
    }

}
