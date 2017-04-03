//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class CurrentUserRepository {

    fileprivate var currentUser: CurrentUser?

    public init() {

    }

}

// MARK: - CurrentUserRepositoryType

extension CurrentUserRepository: CurrentUserRepositoryType {

    public func login(withUserName username: String, andPassword password: String) -> Observable<CurrentUser> {
        return Observable.deferred {
            if username != "pbe" && password != "pbe" {
                return Observable.error(CurrentUserRepositoryError.invalidCredentials)
            }
            let currentUser = CurrentUser(userName: username, firstName: "Phillipp", lastName: "Bertram")
            return Observable.just(currentUser)
        }
    }

    public func logout() -> Observable<Void> {
        return Observable.deferred {
            self.currentUser = nil
            return Observable.just()
        }
    }

    public func getCurrentUser() -> Observable<CurrentUser> {
        return Observable.deferred {

            guard let currentUser = self.currentUser else {
                return Observable.error(CurrentUserRepositoryError.notLoggedIn)
            }

            return Observable.just(currentUser)
        }
    }

    public func isLoggedIn() -> Observable<Bool> {
        return Observable.deferred {
            if self.currentUser != nil {
                return Observable.just(true)
            }
            return Observable.just(false)
        }
    }

}
