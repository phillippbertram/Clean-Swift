//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class MarkMessagesReadUseCase: UseCase<Chat, Void> {

    private let messageRepository: MessageRepositoryType

    public init(schedulerProvider: SchedulerProviderType, messageRepository: MessageRepositoryType) {
        self.messageRepository = messageRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params chat: Chat) -> Observable<Void> {
        return messageRepository
                .getAll(for: chat)
                .flatMap(updateMessages)
                .map({ _ in () })
                .asObservable()
    }

    private func updateMessages(messages: [Message]) -> Single<[Message]> {
        return Single.deferred {
                    let updatedMessages = messages.map { message -> Message in
                        var mutableMessage = message
                        mutableMessage.isRead = true
                        return mutableMessage
                    }
                    return Single.just(updatedMessages)
                }
                .flatMap(messageRepository.updateAll)
    }
}
