//
//  MessageRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public enum MessageRepositoryError: Error {
    case chatNotFound
    case contactNotFound
}

public struct CreateMessageParam {

    public var chatId: String

    public var content: Message.Content
    public var status: Message.Status

    public var sender: Contact
    public var isIncoming: Bool
    public var isRead: Bool

    public var timestamp: Date

    public init(chatId: String,
                content: Message.Content,
                status: Message.Status,
                sender: Contact,
                isIncoming: Bool,
                isRead: Bool,
                timestamp: Date) {
        self.chatId = chatId
        self.content = content
        self.status = status
        self.sender = sender
        self.isIncoming = isIncoming
        self.isRead = isRead
        self.timestamp = timestamp
    }

}

public protocol MessageRepositoryType {

    // MARK: Reading

    /// Gets all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Observable
    func getAll(`for` chat: Chat) -> Observable<[Message]>

    /// Observes all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Observable
    func observeAll(`for` chat: Chat) -> Observable<[Message]>

    // MARK: Creating

    /// Creates or updates given message.
    ///
    /// - Parameter message: message
    /// - Returns: Observable
    func create(message: CreateMessageParam) -> Observable<Message>

    // MARK: Updating

    /// Updates given message. If chat does not exist, it will throw an appropriate error.
    ///
    /// - Parameter message: the Message to update
    /// - Returns: Observable
    func update(message: Message) -> Observable<Message>

    /// Updates all messages. Not existing chats are ignored.
    ///
    /// - Parameter messages: The messages.
    /// - Returns: Observable
    func updateAll(_ messages: [Message]) -> Observable<[Message]>

    // MARK: Deleting

    /// Deletes given message.
    ///
    /// - Parameter message: message to delete
    /// - Returns: Observable
    func delete(message: Message) -> Observable<Void>

}
