//
//  CreateChatForContactUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class CreateChatForContactUseCase: UseCase<Contact, Chat> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params contact: Contact) -> Observable<Chat> {
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
