//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class LoginUseCase: SingleUseCase<LoginUseCaseParams, CurrentUser> {

    private let accountRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                accountUserRepository: AccountRepositoryType) {
        self.accountRepository = accountUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: LoginUseCaseParams) -> Single<CurrentUser> {
        return accountRepository
                .login(withUserName: params.userName, andPassword: params.password)
    }

}

// MARK: Params

public struct LoginUseCaseParams {

    public var userName: String
    public var password: String

    public init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
}
