//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation

public struct ErrorModel: Error {

    public let domain: String
    public let code: Int
    public let message: String

    public var _domain: String {
        return domain
    }
    public var _code: Int {
        return code
    }
}

// used for do … catch branches
public func ~=(lhs: Error, rhs: Error) -> Bool {
    return lhs._domain == rhs._domain && rhs._code == rhs._code
}

public enum GeneralError: Error {

    case notImplemented

}

public func abstractMethod() -> Never {
    fatalError("abstract method")
}

public func notImplemented() -> Never {
    fatalError("has to be implemented")
}