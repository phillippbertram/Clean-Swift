//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

enum LoginError: Error {

    case invalidCredentials

}

public final class LoginUseCase: UseCase<LoginUseCaseParams, CurrentUser> {

    private let currentUserRepository: AccountRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                currentUserRepository: AccountRepositoryType) {
        self.currentUserRepository = currentUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: LoginUseCaseParams) -> Observable<CurrentUser> {
        return currentUserRepository
            .login(withUserName: params.userName, andPassword: params.password)
            .asObservable()
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
