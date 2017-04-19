//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Common

public final class MarkMessagesReadUseCase: CompletableUseCase<Chat> {

    private let messageRepository: MessageRepositoryType

    public init(schedulerProvider: SchedulerProviderType, messageRepository: MessageRepositoryType) {
        self.messageRepository = messageRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params chat: Chat) -> Completable {
        return messageRepository
                .getAll(for: chat)
                .flatMap { [unowned self] messages in
                    return self.updateMessages(messages: messages)
                }
                .asCompletable()
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
