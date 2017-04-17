//
//  MessageRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

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

    /// Creates a message with given parameters.
    ///
    /// - Parameters:
    ///   - text: the message
    ///   - sender: the sender
    ///   - chat: the chat containing the message
    ///   - status: the initial status fo the chat
    /// - Returns: Observable
    func create(text: String, sender: Contact, chat: Chat, status: Message.Status) -> Observable<Message>

    /// Creates or updates given message.
    ///
    /// - Parameter message: message
    /// - Returns: Observable
    func createMessage(_ message: Message) -> Observable<Message>

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
