//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxSwiftExt

public final class MessageDataSourceNetwork {

    fileprivate let messageApi: MessageApiType

    public init(messageApi: MessageApiType) {
        self.messageApi = messageApi
    }

}

extension MessageDataSourceNetwork: MessageDataSource {

    public func getAll(for chat: Chat) -> Single<[Message]> {
        return messageApi.messagesForChat(withId: chat.id).map(mapAll)
    }

}

extension MessageDataSourceNetwork {

    func map(dto: ApiMessage) -> Message {
        return Message(id: dto.id,
                              chatId: dto.chatId,
                              content: .text(dto.content),
                              status: .delivered,
                              senderId: dto.sender,
                              isIncoming: false, // TODO:
                              isRead: false, // TODO:
                              timestamp: dto.timestamp)
    }

    func mapAll(dtos: [ApiMessage]) -> [Message] {
        return dtos.map(map)
    }

}
