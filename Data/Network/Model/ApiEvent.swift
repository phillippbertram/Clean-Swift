//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct ApiEvent {

    public enum `Type` {
        case receivedMessage(ApiMessage)
    }

    public let type: Type
}
