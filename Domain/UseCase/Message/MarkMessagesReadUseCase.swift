//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class MarkMessagesReadUseCase {

    private let messageRepository: MessageRepositoryType

    init(messageRepository: MessageRepositoryType) {
        self.messageRepository = messageRepository
    }

    public func build(chat: Chat) -> Observable<Void> {
        return messageRepository
                .getAll(for: chat)
                .flatMap(updateMessages)
                .map({ _ in () })
    }

    private func updateMessages(messages: [Message]) -> Observable<[Message]> {
        return Observable.deferred {
                    let updatedMessages = messages.map { message -> Message in
                        var mutableMessage = message
                        mutableMessage.isRead = true
                        return mutableMessage
                    }
                    return Observable.just(updatedMessages)
                }
                .flatMap(messageRepository.updateAll)
    }
}
