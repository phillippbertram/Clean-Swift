//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct AppVersion {

    public let version: String
    public let build: Int

    public init(version: String, build: Int) {
        self.version = version
        self.build = build
    }

}
