//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public enum ChatRepositoryError: Error {

    case chatNotFound(id: String)

}

public protocol ChatRepositoryType {

    /// Observes all chats. The Observbable will emit `onNext` events
    /// for each change and will never complete.
    ///
    /// Don't forget to dispose this Observable to release memory if not needed anymore.
    ///
    /// - Returns: Observable
    func observeAll() -> Observable<[Chat]>

    /// Creates a chat
    ///
    /// - Parameter chat: the chat to create
    /// - Returns: Observable
    func create(chat: Chat) -> Observable<Chat>

    /// Find a chat with given id. If chat does not exist, the observable will
    /// emit an appropriate error.
    ///
    /// - Parameter withId: the id.
    /// - Returns: Observable
    func get(byId: String) -> Observable<Chat>

    /// Gets all available chats.
    ///
    /// - Returns: Observable
    func getAll() -> Observable<[Chat]>

}
