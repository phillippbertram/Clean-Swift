//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Common
import Domain
import RxSwift

public final class ChatDataSourceNetwork {

    fileprivate let chatApi: ChatApiType
    fileprivate let contactApi: ContactApiType
    fileprivate let contactMapper = ApiContactDomainMapper()

    public init(chatApi: ChatApiType, contactApi: ContactApiType) {
        self.chatApi = chatApi
        self.contactApi = contactApi
    }
}

// MARK: ChatDataSource

extension ChatDataSourceNetwork: ChatDataSource {

    public func getAll() -> Single<[Chat]> {
        return chatApi
                .getAll()
                .asObservable()
                .flatMap({ Observable.from($0) })
                .flatMap { apiChat in
                    self.contactApi.get(byUsername: apiChat.participant).map({ (apiChat, $0) })
                }
                .map { [unowned self] (apiChat, apiContact) in
                    self.map(apiChat: apiChat, participant: apiContact)
                }
                .toArray()
                .asSingle()
    }

    public func get(forUserName: String) -> Single<Chat> {
        notImplemented()
    }

    public func get(byId chatId: String) -> Single<Chat> {
        return chatApi.get(byId: chatId)
                .flatMap { apiChat in
                    self.contactApi.get(byUsername: apiChat.participant).map({ (apiChat, $0) })
                }
                .map { [unowned self] (apiChat, apiContact) in
                    self.map(apiChat: apiChat, participant: apiContact)
                }

    }

}

// MARK: Mapping

private extension ChatDataSourceNetwork {

    func map(apiChat: ApiChat, participant: ApiContact) -> Chat {
        let contact = contactMapper.map(apiContact: participant)
        return Chat(id: apiChat.id,
                    participant: contact,
                    lastMessage: nil,
                    modifiedAt: apiChat.modifiedAt,
                    createdAt: apiChat.createdAt)
    }

}
