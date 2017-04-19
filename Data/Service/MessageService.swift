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

    public func send(message: Message, toContact userName: String) -> Single<Message> {
        let request = MessageRequestDTO()
        return messageAPI.send(message: request, receiver: userName)
                .map { messageDTO in
                    return message // TODO: implement me
                }
                .delay(1, scheduler: MainScheduler.instance)
                .flatMap { _ in
                    Single<Message>.error(APIError.general)
                }
    }
}
