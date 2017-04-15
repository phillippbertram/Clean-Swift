//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class SendMessageUseCase {

    public enum MessageResult {
        case sending(progress: Double)
    }

    private let createChatUseCase: CreateChatForContactUseCase
    private let messageRepository: MessageRepositoryType
    private let messageService: MessageServiceType
    private let currentUserRepository: CurrentUserRepositoryType

    public init(createChatUseCase: CreateChatForContactUseCase,
                messageRepository: MessageRepositoryType,
                messageService: MessageServiceType,
                currentUserRepository: CurrentUserRepositoryType) {

        self.createChatUseCase = createChatUseCase
        self.messageRepository = messageRepository
        self.messageService = messageService
        self.currentUserRepository = currentUserRepository
    }

    public func build(chat: Chat, messageText: String) -> Observable<MessageResult> {
        return createChatUseCase
                .build(withContact: chat.participant)
                .flatMap { [unowned self] chat in
                    self.currentUserRepository.getCurrentUser().map({ ($0, chat) })
                }
                .flatMap { (currentUser, chat) in
                    self.messageRepository
                            .create(text: messageText, sender: currentUser.asContact(), chat: chat, status: .sending)
                }
                .flatMap { message in
                    return self.messageService
                            .send(message: message, toContact: chat.participant.userName)
                            .catchError { error in
                                return self.handleError(error, forMessage: message)
                            }
                }
                .map({ _ in MessageResult.sending(progress: 1) })
    }

    private func handleError(_ error: Error, forMessage message: Message) -> Observable<Message> {
        var modifiedMessage = message
        modifiedMessage.status = .failure(error)
        return messageRepository.update(message: modifiedMessage)
    }

}
