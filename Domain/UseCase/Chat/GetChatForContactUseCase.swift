//
//  GetChatForContactUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 12/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class GetChatForContactUseCase {

    private let chatRepository: ChatRepositoryType

    public init(chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
    }

    public func build(contact: Contact) -> Observable<Chat> {
        return chatRepository.get(forContact: contact).asObservable()
    }

}
