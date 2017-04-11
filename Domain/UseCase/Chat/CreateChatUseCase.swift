//
//  CreateChatUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class CreateChatUseCase {

    private let chatRepository: ChatRepositoryType

    public init(chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
    }

    public func build(withContact contact: Contact) -> Observable<Chat> {
        return chatRepository
                .getAll()
                .map { chats in
                    if let firstChat = chats.filter({ $0.participant == contact }).first {
                        return firstChat
                    }
                    return Chat(id: UUID().uuidString,
                                participant: contact,
                                lastMessage: nil,
                                lastModifiedAt: Date(),
                                createdAt: Date())
                }
                .flatMap(chatRepository.create)
    }

}
