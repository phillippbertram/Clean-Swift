//
//  GetChatForContactUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 12/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class GetChatForContactUseCase: SingleUseCase<Contact, Chat> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType, chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params contact: Contact) -> Single<Chat> {
        return chatRepository.get(forContact: contact)
    }

}
