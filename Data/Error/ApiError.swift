//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case http(statusCode: Int)
    case invalidCredentials

    case contactNotFound
    case chatNotFound
}
