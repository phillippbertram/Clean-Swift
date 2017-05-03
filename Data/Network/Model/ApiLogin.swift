//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct ApiLogin {

    public let userName: String
    public let firstName: String
    public let lastName: String

}

// MARK: Hashable

extension ApiLogin: Hashable {

    public var hashValue: Int {
        return userName.hashValue
    }

    public static func == (lhs: ApiLogin, rhs: ApiLogin) -> Bool {
        return lhs.userName == rhs.userName
    }

}
