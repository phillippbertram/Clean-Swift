//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class SendMessageUseCase {

    public enum MessageResult {
        case sending(progress: Double)
    }

    private let createChatUseCase: CreateChatUseCase
    private let messageRepository: MessageRepositoryType
    private let messageService: MessageServiceType

    init(createChatUseCase: CreateChatUseCase,
            messageRepository: MessageRepositoryType,
            messageService: MessageServiceType) {
        self.createChatUseCase = createChatUseCase
        self.messageRepository = messageRepository
        self.messageService = messageService
    }

    public func build(user: Contact, messageText: String) -> Observable<MessageResult> {
        return createChatUseCase
                .build(withUser: user.userName)
                .flatMap { chat in
                    self.messageRepository
                            .create(message: messageText, sender: user, chat: chat, status: .sending)
                }
                .flatMap { message in
                    return self.messageService
                            .send(message: message)
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
