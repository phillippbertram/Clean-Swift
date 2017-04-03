//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class LoginUseCase {

    private let currentUserRepository: CurrentUserRepositoryType

    public init(currentUserRepository: CurrentUserRepositoryType) {
        self.currentUserRepository = currentUserRepository
    }

    public func build(withUserName userName: String, andPassword password: String) -> Observable<CurrentUser> {
        return currentUserRepository.login(withUserName: userName, andPassword: password)
    }

}
