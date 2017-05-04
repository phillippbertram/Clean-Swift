//
//  MessageRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public struct CreateMessageParam {

    public var chatId: String
    public var remoteId: String?

    public var content: Message.Content
    public var status: Message.Status

    public var sender: Contact
    public var isIncoming: Bool
    public var isRead: Bool

    public var timestamp: Date

    public init(chatId: String,
                remoteId: String?,
                content: Message.Content,
                status: Message.Status,
                sender: Contact,
                isIncoming: Bool,
                isRead: Bool,
                timestamp: Date) {
        self.chatId = chatId
        self.remoteId = remoteId
        self.content = content
        self.status = status
        self.sender = sender
        self.isIncoming = isIncoming
        self.isRead = isRead
        self.timestamp = timestamp
    }

}

public protocol MessageRepositoryType {

    // MARK: Sending

    func send(message: Message, receiver: String) -> Single<Message>

    // MARK: Reading

    /// Gets all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Single
    func getAll(`for` chat: Chat) -> Single<[Message]>

    // MARK: Creating

    /// Creates or updates given message.
    ///
    /// - Parameter message: message
    /// - Returns: Observable
    func create(message: CreateMessageParam) -> Single<Message>

    // MARK: Updating

    /// Updates given message. If chat does not exist, it will throw an appropriate error.
    ///
    /// - Parameter message: the Message to update
    /// - Returns: Observable
    func update(message: Message) -> Single<Message>

    /// Updates all messages. Not existing chats are ignored.
    ///
    /// - Parameter messages: The messages.
    /// - Returns: Observable
    func updateAll(_ messages: [Message]) -> Single<[Message]>

    // MARK: Deleting

    /// Deletes given message.
    ///
    /// - Parameter message: message to delete
    /// - Returns: Observable
    func delete(message: Message) -> Completable

}
