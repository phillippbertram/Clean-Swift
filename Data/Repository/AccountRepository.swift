//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class AccountRepository {

    fileprivate let currentUser: Variable<CurrentUser?> = Variable(nil)

    fileprivate let loginApi: LoginApiType

    public init(loginApi: LoginApiType) {
        self.loginApi = loginApi
    }

}

// MARK: - CurrentUserRepositoryType

extension AccountRepository: AccountRepositoryType {

    public func login(withUserName userName: String, andPassword password: String) -> Single<CurrentUser> {
        return loginApi
                .login(with: userName, and: password)
                .map { loginData in
                    CurrentUser(userName: loginData.userName,
                                password: password,
                                firstName: loginData.firstName,
                                lastName: loginData.lastName)
                }
    }

    public func logout() -> Completable {
        return Completable.deferred {
            self.currentUser.value = nil
            return Completable.empty()
        }
    }

    public func getCurrentUser() -> Single<CurrentUser> {
        return Single.deferred {

            guard let currentUser = self.currentUser.value else {
                return Single.error(AccountRepositoryError.notLoggedIn)
            }

            return Single.just(currentUser)
        }
    }

    public func isLoggedIn() -> Observable<Bool> {
        return currentUser.asObservable().map({ $0 != nil }).distinctUntilChanged()
    }

}
