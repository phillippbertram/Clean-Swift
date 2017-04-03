//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

final class CurrentUserRepository {

    fileprivate var currentUser: CurrentUser?

    init() {

    }

}

// MARK: - CurrentUserRepositoryType

extension CurrentUserRepository: CurrentUserRepositoryType {

    func login(withUserName username: String, andPassword password: String) -> Observable<CurrentUser> {
        return Observable.deferred {
            if username != "pbe" && password != "pbe" {
                return Observable.error(CurrentUserRepositoryError.invalidCredentials)
            }
            let currentUser = CurrentUser(userName: username, firstName: "Phillipp", lastName: "Bertram")
            return Observable.just(currentUser)
        }
    }

    func logout() -> Observable<Void> {
        return Observable.deferred {
            self.currentUser = nil
            return Observable.just()
        }
    }

    func getCurrentUser() -> Observable<CurrentUser> {
        return Observable.deferred {

            guard let currentUser = self.currentUser else {
                return Observable.error(CurrentUserRepositoryError.notLoggedIn)
            }

            return Observable.just(currentUser)
        }
    }

    func isLoggedIn() -> Observable<Bool> {
        return Observable.deferred {
            if self.currentUser != nil {
                return Observable.just(true)
            }
            return Observable.just(false)
        }
    }

}
