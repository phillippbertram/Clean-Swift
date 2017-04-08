//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

@testable import Domain

class MockCurrentUserRepository: CurrentUserRepositoryType {

    init() {

    }

    var loginObservableStub: ((String, String) -> Observable<CurrentUser>)?
    func login(withUserName username: String, andPassword password: String) -> Observable<CurrentUser> {
        return loginObservableStub!(username, password)
    }

    func logout() -> Observable<Void> {
        return Observable.empty()
    }

    func getCurrentUser() -> Observable<CurrentUser> {
        return Observable.empty()
    }

    func isLoggedIn() -> Observable<Bool> {
        return Observable.empty()
    }

}
