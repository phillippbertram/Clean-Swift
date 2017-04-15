//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public enum CurrentUserRepositoryError: Error {

    case invalidCredentials
    case notLoggedIn

}

public protocol CurrentUserRepositoryType {

    /// Tries to login the user with given credentials.
    ///
    /// - Parameters:
    ///   - username: the user name.
    ///   - password: awesome secret.
    /// - Returns: Observable
    func login(withUserName username: String, andPassword password: String) -> Observable<CurrentUser>

    /// Deletes the entire user model and its credentials.
    ///
    /// - Returns: Observable
    func logout() -> Observable<Void>

    /// Gets the current user. If not available, it will emit a `notLoggedIn` error.
    ///
    /// - Returns: Observable
    func getCurrentUser() -> Observable<CurrentUser>

    /// Indicates if the user is logged in or not.
    ///
    /// - Returns: Observable
    func isLoggedIn() -> Observable<Bool>

}
