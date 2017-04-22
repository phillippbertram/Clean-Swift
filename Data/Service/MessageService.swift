//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 10/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class MessageService {

    fileprivate let accountRepository: AccountRepositoryType

    public init(accountRepository: AccountRepositoryType) {
        self.accountRepository = accountRepository
    }

}

// MARK: - Public API

extension MessageService: MessageServiceType {

    public func send(message request: MessageRequestDTO, receiver: String) -> Single<MessageDTO> {
        return accountRepository.getCurrentUser().flatMap { currentUser in
            var messageDTO = MessageDTO()
            messageDTO.chatId = "123-456"
            messageDTO.id = UUID().uuidString
            messageDTO.sender = currentUser.userName
            messageDTO.messageStatus = .delivered
            messageDTO.timestamp = Date()
            return Single.just(messageDTO)
        }
    }

    public func messagesForChat(withId: String) -> Single<[MessageDTO]> {
        return Single.deferred {
            var m1 = MessageDTO()
            m1.content = "Message 1"
            m1.status = "DELIVERED"
            m1.timestamp = Date()
            m1.sender = "pbe"
            m1.id = UUID().uuidString
            m1.chatId = "123-456"

            var m2 = MessageDTO()
            m2.content = "Message 2"
            m2.status = "DELIVERED"
            m2.timestamp = Date()
            m2.sender = "alb"
            m2.id = UUID().uuidString
            m2.chatId = "123-456"

            return Single.just([m1, m2])
        }
    }

}
