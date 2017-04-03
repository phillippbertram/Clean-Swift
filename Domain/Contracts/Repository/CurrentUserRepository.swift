//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public enum CurrentUserRepositoryError: Error {

    case invalidCredentials
    case notLoggedIn

}

public protocol CurrentUserRepositoryType {

    func login(withUserName: String, andPassword: String) -> Observable<CurrentUser>

    func logout() -> Observable<Void>

    func getCurrentUser() -> Observable<CurrentUser>

    func isLoggedIn() -> Observable<Bool>

}
