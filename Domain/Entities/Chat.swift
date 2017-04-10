//
//  Chat.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct Chat {

    public let id: String

    public let participant: Contact
    public let lastMessage: Message?

    public let lastModifiedAt: Date
    public let createdAt: Date

    public init(
            id: String,
            participant: Contact,
            lastMessage: Message?,
            lastModifiedAt: Date,
            createdAt: Date) {
        self.id = id
        self.participant = participant
        self.lastMessage = lastMessage
        self.lastModifiedAt = lastModifiedAt
        self.createdAt = createdAt
    }

}

// MARK: - Comparable, Hashable

extension Chat: Comparable, Hashable {

    public var hashValue: Int {
        return id.hash
    }

    public static func < (lhs: Chat, rhs: Chat) -> Bool {
        if let lhsLastMessage = lhs.lastMessage, let rhsLastMessage = rhs.lastMessage {
            return lhsLastMessage < rhsLastMessage
        }

        return lhs.lastModifiedAt < rhs.lastModifiedAt
    }

    public static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }

}
