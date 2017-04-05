//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

enum LoginError: Error {

    case invalidCredentials

}

public final class LoginUseCase: UseCase<LoginUseCase.Params, CurrentUser> {

    private let currentUserRepository: CurrentUserRepositoryType

    public init(schedulerProvider: SchedulerProviderType, currentUserRepository: CurrentUserRepositoryType) {
        self.currentUserRepository = currentUserRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: LoginUseCase.Params) -> Observable<CurrentUser> {
        return currentUserRepository
            .login(withUserName: params.userName, andPassword: params.password)
    }

    // MARK: Password

    public struct Params {

        public var userName: String
        public var password: String

        public init(userName: String, password: String) {
            self.userName = userName
            self.password = password
        }
    }

}
