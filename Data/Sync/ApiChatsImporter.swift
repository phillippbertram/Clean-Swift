//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class ApiChatsImporter {

    private let chatRepository: ChatRepositoryType

    public init(chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
    }

    func build(params chatDTOs: [ApiChat]) -> Single<[Chat]> {
        return Observable
                .from(chatDTOs)
                .map { chatDTO in
                    var participant: Contact!
                    return CreateChatParam.for(participant: participant)
                }
                .flatMap { [unowned self] in
                    self.chatRepository.create(chat: $0)
                }
                .toArray()
                .asSingle()
    }

}
