//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

@testable import Domain

class MockCurrentUserRepository: CurrentUserRepositoryType {

    var loginObservableStub: ((String, String) -> Observable<CurrentUser>)?
    func login(withUserName username: String, andPassword password: String) -> Observable<CurrentUser> {
        return loginObservableStub!(username, password)
    }

    var logoutStub: (() -> Observable<Void>)?
    func logout() -> Observable<Void> {
        return logoutStub!()
    }

    var getCurrentUserStub: (() -> Observable<CurrentUser>)?
    func getCurrentUser() -> Observable<CurrentUser> {
        return getCurrentUserStub!()
    }

    var isLoggedInStub: (() -> Observable<Bool>)?
    func isLoggedIn() -> Observable<Bool> {
        return isLoggedInStub!()
    }

}
