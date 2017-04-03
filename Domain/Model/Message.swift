//
//  Message.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct Message {

    public enum Content {
        case text(String)
        case image(Data)
    }

    public enum Status {
        case sending
        case failure(Error)
        case delivered
    }

    public var id: String
    public var content: Content
    public var status: Status

    public var sender: Contact
    public var isIncoming: Bool
    public var timestamp: Date

}
