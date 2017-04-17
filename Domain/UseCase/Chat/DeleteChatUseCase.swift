//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class DeleteChatUseCase: UseCase<Chat, Void> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType, chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params chat: Chat) -> Observable<Void> {
        return chatRepository.delete(chat: chat)
    }

}
