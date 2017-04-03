//
//  Chat.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct Chat {

    public let id: String
    public let participant: Contact
    public let lastMessage: Message?

    public init(id: String, participant: Contact, lastMessage: Message?) {
        self.id = id
        self.participant = participant
        self.lastMessage = lastMessage
    }

}

// MARK: - Comparable

extension Chat: Comparable {

    public static func <(lhs: Chat, rhs: Chat) -> Bool {
        guard let lhsLastMessage = lhs.lastMessage, let rhsLastMessage = rhs.lastMessage else {
            return false
        }
        return lhsLastMessage < rhsLastMessage
    }

    public static func ==(lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }

}