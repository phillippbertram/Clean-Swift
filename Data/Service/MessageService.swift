//
//  MessageService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class MessageService {

    fileprivate let messageAPI: MessageAPI

    public init(messageAPI: MessageAPI) {
        self.messageAPI = messageAPI
    }

}

// MARK: - MessageServiceType

extension MessageService: MessageServiceType {

    public func send(message: Message, toContact userName: String) -> Observable<Message> {
        let request = MessageRequestDTO()
        return messageAPI.send(message: request, receiver: userName)
                .map { messageDTO in
                    return Message(dto: messageDTO,
                                   sender: message.sender,
                                   isIncoming: message.isIncoming,
                                   isRead: message.isRead)
                }
    }
}
