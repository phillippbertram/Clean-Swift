//
//  CreateChatForContactUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class CreateChatForContactUseCase: SingleUseCase<Contact, Chat> {

    private let chatRepository: ChatRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params contact: Contact) -> Single<Chat> {
        return chatRepository
                .get(forContact: contact)
                .catchError { [unowned self] error -> Single<Chat> in
                    if case ChatRepositoryError.chatNotFound = error {
                        return self.createChat(participant: contact)
                    }
                    return Single.error(error)
                }
    }

    private func createChat(participant: Contact) -> Single<Chat> {
        return Single.deferred { [unowned self] in
            let param = CreateChatParam.for(participant: participant)
            return self.chatRepository.create(chat: param)
        }
    }

}
