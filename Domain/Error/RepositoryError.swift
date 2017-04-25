//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

// MARK: - AccountRepositoryError

public enum AccountRepositoryError: Error {
    case invalidCredentials
    case notLoggedIn
}

// MARK: - ChatRepositoryError

public enum ChatRepositoryError: Error {
    case chatNotFound
}

// MARK: - ContactRepositoryError

public enum ContactRepositoryError: Error {
    case contactNotFound
}

// MARK: - MessageRepositoryError

public enum MessageRepositoryError: Error {
    case chatNotFound
    case contactNotFound
    case messageNotFound
}
