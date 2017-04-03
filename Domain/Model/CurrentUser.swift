//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct CurrentUser {

    public let userName: String
    public let firstName: String
    public let lastName: String

    public init(userName: String, firstName: String, lastName: String) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
    }

}
