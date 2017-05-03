//
// Created by Phillipp Bertram on 02.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain

public final class SessionManager {

    var isLoggedIn: Bool {
        return currentUser != nil
    }

    var currentUser: CurrentUser?

    func createSession(withUserName: String, andPassword: String) {

    }

}
