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

    public func build(withUser userId: String) -> Observable<Chat> {
        let contact = Contact(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        let chat = Chat(id: "", participant: contact, lastMessage: nil)
        return chatRepository.create(chat: chat)
    }


}
