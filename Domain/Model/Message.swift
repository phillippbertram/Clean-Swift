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

    internal(set) public var id: String
    internal(set) public var chatId: String

    internal(set) public var content: Content
    internal(set) public var status: Status

    internal(set) public var sender: Contact
    internal(set) public var isIncoming: Bool

    internal(set) public var timestamp: Date
    public var lastModifiedAt: Date

    public init(
            id: String,
            chatId: String,
            content: Content,
            status: Status,
            sender: Contact,
            isIncoming: Bool,
            timestamp: Date,
            lastModifiedAt: Date) {
        self.id = id
        self.chatId = chatId
        self.content = content
        self.status = status
        self.sender = sender
        self.isIncoming = isIncoming
        self.timestamp = timestamp
        self.lastModifiedAt = lastModifiedAt
    }

}

// MARK: - Comparable

extension Message: Comparable {

    public static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.lastModifiedAt < rhs.lastModifiedAt
    }

    public static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }

}
