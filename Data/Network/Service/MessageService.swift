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
    fileprivate let contactService: ContactServiceType

    init(messageAPI: MessageAPI, contactService: ContactServiceType) {
        self.messageAPI = messageAPI
        self.contactService = contactService
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

    public func getAllForChat(withId chatId: String, currentUser: CurrentUser) -> Observable<[Message]> {
        return messageAPI
                .getAllForChat(withId: chatId)
                .flatMap({ Observable.from($0) })
                .flatMap { messageDTO in
                    return self.contactService
                            .get(byUserName: messageDTO.sender)
                            .map { sender in
                                Message(dto: messageDTO,
                                        sender: sender,
                                        isIncoming: currentUser.userName == sender.userName,
                                        isRead: true)
                            }
                }
                .toArray()
    }

}
