//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class ImportApiChatsUseCase: SingleUseCase<[ChatDTO], [Chat]> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params chatDTOs: [ChatDTO]) -> Single<[Chat]> {
        return Observable
                .from(chatDTOs)
                .map { chatDTO in
                    var participant: Contact!
                    return CreateChatParam(participant: participant)
                }
                .flatMap { [unowned self] in
                    self.chatRepository.create(chat: $0)
                }
                .toArray()
                .asSingle()
    }

}
