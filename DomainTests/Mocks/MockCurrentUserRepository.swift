//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

@testable import Domain

class MockCurrentUserRepository: AccountRepositoryType {

    var loginObservableStub: ((String, String) -> Single<CurrentUser>)?
    func login(withUserName username: String, andPassword password: String) -> Single<CurrentUser> {
        return loginObservableStub!(username, password)
    }

    var logoutStub: (() -> Completable)?
    func logout() -> Completable {
        return logoutStub!()
    }

    var getCurrentUserStub: (() -> Single<CurrentUser>)?
    func getCurrentUser() -> Single<CurrentUser> {
        return getCurrentUserStub!()
    }

    var isLoggedInStub: (() -> Observable<Bool>)?
    func isLoggedIn() -> Observable<Bool> {
        return isLoggedInStub!()
    }

}
