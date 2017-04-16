//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class AccountRepository {

    fileprivate var data: Set<CurrentUser> = []

    fileprivate var currentUser: CurrentUser?

    public init() {

        let pbe = CurrentUser(userName: "pbe", password: "pbe", firstName: "Phillipp", lastName: "Bertram")
        let alb = CurrentUser(userName: "alb", password: "alb", firstName: "Alexander", lastName: "Brechmann")
        let nih = CurrentUser(userName: "nih", password: "nih", firstName: "Nils", lastName: "Hohmann")
        let waw = CurrentUser(userName: "waw", password: "waw", firstName: "Waldemar", lastName: "Weißhaar")
        let cwo = CurrentUser(userName: "cwo", password: "cwo", firstName: "Christof", lastName: "Wolke")
        let mdr = CurrentUser(userName: "mdr", password: "mdr", firstName: "Matthias", lastName: "Dierker")

        data.insert(pbe)
        data.insert(alb)
        data.insert(nih)
        data.insert(waw)
        data.insert(cwo)
        data.insert(mdr)

    }

}

// MARK: - CurrentUserRepositoryType

extension AccountRepository: AccountRepositoryType {

    public func login(withUserName userName: String, andPassword password: String) -> Observable<CurrentUser> {
        return Observable.deferred { [unowned self] in

            guard let user = self.data.filter({$0.userName == userName}).first else {
                return Observable.error(AccountRepositoryError.invalidCredentials)
            }

            guard user.password == password else {
                return Observable.error(AccountRepositoryError.invalidCredentials)
            }

            self.currentUser = user
            return Observable.just(user)
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
                return Observable.error(AccountRepositoryError.notLoggedIn)
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
