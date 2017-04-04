//
//  GetChatsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class GetChatsUseCase {

    private let chatRepository: ChatRepositoryType
    private let chatService: ChatServiceType

    public init(chatRepository: ChatRepositoryType, chatService: ChatServiceType) {
        self.chatRepository = chatRepository
        self.chatService = chatService
    }

    public func build() -> Observable<[Chat]> {
        return chatRepository.getAllChats().map({$0.sorted(by: <)})
    }

}
