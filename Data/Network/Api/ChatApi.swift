//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public protocol ChatApiType {

    /// Returns all conversations
    ///
    /// - Returns: Single
    func getAll() -> Single<[ApiChat]>

    /// Returns conversation by given identifier
    ///
    /// - Parameter id: chat id
    /// - Returns: Single
    func get(byId id: String) -> Single<ApiChat>

}

public final class ChatApi: BaseApi<ApiChat> {

    public init() {
        super.init("http://localhost:3000")
    }

}

// MARK: - ChatAPIType

extension ChatApi: ChatApiType {

    public func getAll() -> Single<[ApiChat]> {
        return getItems("chats")
    }

    public func get(byId id: String) -> Single<ApiChat> {
        return getItem("chat", itemId: id)
    }

}
