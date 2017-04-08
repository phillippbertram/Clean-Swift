//
//  User.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct Contact {

    /// The unique username
    public let userName: String

    /// first name
    public let firstName: String

    /// last name
    public let lastName: String

    public init(userName: String, firstName: String, lastName: String) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
    }

}

// MARK: - Comparable

extension Contact: Comparable, Hashable {

    public var hashValue: Int {
        return userName.hash
    }

    public static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.lastName < rhs.lastName
    }

    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.userName == rhs.userName
    }

}
