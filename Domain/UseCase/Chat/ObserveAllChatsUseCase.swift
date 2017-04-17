//
//  ObserveAllChatsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ObserveAllChatsUseCase: UseCase<Void, [Chat]> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType, chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: Void) -> Observable<[Chat]> {
        return chatRepository.observeAll().map({ $0.sorted(by: <) })
    }

}
