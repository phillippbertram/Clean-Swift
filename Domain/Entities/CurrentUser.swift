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

    public func asContact() -> Contact {
        return Contact(userName: userName, firstName: firstName, lastName: lastName)
    }

}

// MARK: - Hashable

extension CurrentUser: Hashable {

    public var hashValue: Int {
        return userName.hash
    }

    public static func == (lhs: CurrentUser, rhs: CurrentUser) -> Bool {
        return lhs.userName == rhs.userName
    }

}
