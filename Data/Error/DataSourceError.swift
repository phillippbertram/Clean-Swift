//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case contactNotFound

    case chatNotFound
    case failedDeletingChat

    case messageNotFound
}
