//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class DeleteMessageUseCase: UseCase<Message, Void> {

    private let messageRepository: MessageRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                  messageRepository: MessageRepositoryType) {
        self.messageRepository = messageRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Message) -> Observable<Void> {
        return messageRepository.delete(message: params)
    }


}
