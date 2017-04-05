//
//  MessageRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public protocol MessageRepositoryType {

    // Reading

    /// Gets all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Observable
    func getAll(`for` chat: Chat) -> Observable<[Message]>

    // Creating

    /// Creates a message with given parameters.
    ///
    /// - Parameters:
    ///   - message: the message
    ///   - sender: the sender
    ///   - chat: the chat containing the message
    ///   - status: the initial status fo the chat
    /// - Returns: Observable
    func create(message: String, sender: Contact, chat: Chat, status: Message.Status) -> Observable<Message>

    // Updating

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

}
