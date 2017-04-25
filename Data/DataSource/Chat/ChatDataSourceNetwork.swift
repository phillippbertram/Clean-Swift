//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ChatDataSourceNetwork {

    fileprivate let chatApi: ChatApiType

    public init(chatApi: ChatApiType) {
        self.chatApi = chatApi
    }
}

// MARK: ChatDataSource

extension ChatDataSourceNetwork: ChatDataSource {

    func getAll() -> Single<[Chat]> {
        return chatApi
                .getAll()
                .asObservable()
                .flatMap({ Observable.from($0) })
                .map { [unowned self] in
                    self.map(apiChat: $0)
                }
                .toArray()
                .asSingle()
    }

    func get(byId chatId: String) -> Single<Chat> {
        return chatApi
                .get(byId: chatId)
                .map { [unowned self] in
                    self.map(apiChat: $0)
                }
    }

}

// MARK: Mapping

private extension ChatDataSourceNetwork {

    func map(apiChat: ApiChat) -> Chat {
        return Chat(id: apiChat.id,
                    participant: Contact(userName: "", firstName: "", lastName: ""), // TODO:
                    lastMessage: nil,
                    modifiedAt: apiChat.modifiedAt,
                    createdAt: apiChat.createdAt)
    }

}
