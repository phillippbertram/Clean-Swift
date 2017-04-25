//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 10/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public protocol MessageApiType {

    /// Sends a message to given recipient.
    ///
    /// - Parameters:
    ///   - request: request
    ///   - receiver: reveiverId
    /// - Returns: Single
    func send(message request: ApiMessageRequest, receiver: String) -> Single<ApiMessage>

    /// returns all messages for given chat.
    ///
    /// - Parameter withId: chat identifier
    /// - Returns: Single
    func messagesForChat(withId: String) -> Single<[ApiMessage]>

}

public final class MessageApi {

    fileprivate let accountRepository: AccountRepositoryType

    public init(accountRepository: AccountRepositoryType) {
        self.accountRepository = accountRepository
    }

}

// MARK: - Public API

extension MessageApi: MessageApiType {

    public func send(message request: ApiMessageRequest, receiver: String) -> Single<ApiMessage> {
        return accountRepository.getCurrentUser().flatMap { currentUser in
            var messageDTO = ApiMessage()
            messageDTO.chatId = "123-456"
            messageDTO.id = UUID().uuidString
            messageDTO.sender = currentUser.userName
            messageDTO.messageStatus = .delivered
            messageDTO.timestamp = Date()
            return Single.just(messageDTO)
        }
    }

    public func messagesForChat(withId: String) -> Single<[ApiMessage]> {
        return Single.deferred {
            var m1 = ApiMessage()
            m1.content = "Message 1"
            m1.status = "DELIVERED"
            m1.timestamp = Date()
            m1.sender = "pbe"
            m1.id = UUID().uuidString
            m1.chatId = "123-456"

            var m2 = ApiMessage()
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
