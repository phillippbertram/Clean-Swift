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
    ///   - receiver: receiverId
    /// - Returns: Single
    func send(message request: ApiMessageRequest, receiver: String) -> Single<ApiMessage>

    /// returns all messages for given chat.
    ///
    /// - Parameter withId: chat identifier
    /// - Returns: Single
    func messagesForChat(withId: String) -> Single<[ApiMessage]>

}

public final class MessageApi: BaseApi<ApiMessage> {

    fileprivate let accountRepository: AccountRepositoryType

    public init(accountRepository: AccountRepositoryType) {
        self.accountRepository = accountRepository
        super.init("http://localhost:3000")
    }

}

// MARK: - Public API

extension MessageApi: MessageApiType {

    public func send(message request: ApiMessageRequest, receiver: String) -> Single<ApiMessage> {
        return accountRepository.getCurrentUser().flatMap { currentUser in
            // TODO:
            var messageDTO = ApiMessage()
            messageDTO.chatId = "123-456"
            messageDTO.id = UUID().uuidString
            messageDTO.sender = currentUser.userName
            messageDTO.messageStatus = .delivered
            messageDTO.timestamp = Date()
            return Single.just(messageDTO)
        }
    }

    public func messagesForChat(withId chatId: String) -> Single<[ApiMessage]> {
        return getItems("messages").map { apiMessages in
            return apiMessages.filter({ $0.chatId == chatId })
        }
    }

}
