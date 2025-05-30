//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public enum AccountRepositoryError: Error {

    case invalidCredentials
    case notLoggedIn

}

public protocol AccountRepositoryType {

    /// Tries to login the user with given credentials.
    ///
    /// - Parameters:
    ///   - username: the user name.
    ///   - password: awesome secret.
    /// - Returns: Observable
    func login(withUserName username: String, andPassword password: String) -> Single<CurrentUser>

    /// Deletes the entire user model and its credentials.
    ///
    /// - Returns: Observable
    func logout() -> Completable

    /// Gets the current user. If not available, it will emit a `notLoggedIn` error.
    ///
    /// - Returns: Observable
    func getCurrentUser() -> Single<CurrentUser>

    /// Indicates if the user is logged in or not.
    ///
    /// - Returns: Observable
    func isLoggedIn() -> Observable<Bool>

}
