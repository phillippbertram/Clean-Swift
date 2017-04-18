//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class LogoutUseCase: UseCase<Void, Never> {

    fileprivate let currentUserRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType, currentUserRepository: AccountRepositoryType) {
        self.currentUserRepository = currentUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Void) -> Observable<Never> {
        return self.currentUserRepository.logout().asObservable()
    }

}
