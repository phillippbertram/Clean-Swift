//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct CurrentUser {

    public let userName: String
    public let password: String

    public let firstName: String
    public let lastName: String

    public init(userName: String, password: String, firstName: String, lastName: String) {
        self.userName = userName
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }

}
