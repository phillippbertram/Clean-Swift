//
//  Message.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct Message {

    // MARK: Enums

    public enum Content {
        case text(String)
        case image(Data)
    }

    public enum Status {
        case sending
        case sent
        case failure
        case delivered
    }

    // MARK: Properties

    public var id: String
    public var chatId: String

    public var content: Content
    public var status: Status

    public var sender: Contact
    public var isIncoming: Bool
    public var isRead: Bool

    public var timestamp: Date

    public init(
            id: String,
            chatId: String,
            content: Content,
            status: Status,
            sender: Contact,
            isIncoming: Bool,
            isRead: Bool,
            timestamp: Date) {
        self.id = id
        self.chatId = chatId
        self.content = content
        self.status = status
        self.sender = sender
        self.isRead = isRead
        self.isIncoming = isIncoming
        self.timestamp = timestamp
    }

}

// MARK: - Convenience

public extension Message {

    var text: String? {
        return content.text
    }

}

public extension Message.Content {

    var isText: Bool {
        if case .text(_) = self {
            return true
        }
        return false
    }

    var text: String? {
        switch self {
        case .text(let message):
            return message
        default: return nil
        }
    }

}

// MARK: - Comparable

extension Message: Comparable, Hashable {

    public var hashValue: Int {
        return id.hash
    }

    public static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }

    public static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }

}
