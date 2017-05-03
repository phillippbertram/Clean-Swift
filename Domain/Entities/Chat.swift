//
//  Chat.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

/// Entity that represents a conversation with a user

public struct Chat {

    /// Unique identifier
    public var id: String

    /// participant of the chat
    public var participant: Contact

    /// last message if exists
    public var lastMessage: Message?

    /// last modification date
    public var modifiedAt: Date

    /// creation date
    public var createdAt: Date

    public init(
            id: String,
            participant: Contact,
            lastMessage: Message?,
            modifiedAt: Date,
            createdAt: Date) {
        self.id = id
        self.participant = participant
        self.lastMessage = lastMessage
        self.modifiedAt = modifiedAt
        self.createdAt = createdAt
    }

}

// MARK: - Convenience

extension Chat {

    var canSendMessage: Bool {
        return true
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

        return lhs.modifiedAt < rhs.modifiedAt
    }

    public static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }

}
