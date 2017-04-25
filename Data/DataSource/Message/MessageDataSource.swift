//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public protocol MessageDataSource {

    /// Gets all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Single
    func getAll(`for` chat: Chat) -> Single<[Message]>

    /// Gets a message for given remote identifier.
    ///
    /// - Parameter remoteId: the remote identifier.
    /// - Returns: Observable
    func find(byRemoteId remoteId: String) -> Single<Message>

    /// Observes all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Observable
    func observeAll(`for` chat: Chat) -> Observable<[Message]>

}