//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct EventDTO {

    public enum `Type` {
        case receivedMessage(MessageDTO)
    }

    public let type: Type
}
