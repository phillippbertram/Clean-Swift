//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class DeleteMessageUseCase: CompletableUseCase<Message> {

    private let messageRepository: MessageRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                messageRepository: MessageRepositoryType) {
        self.messageRepository = messageRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Message) -> Completable {
        return messageRepository.delete(message: params)
    }

}
