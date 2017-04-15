//
//  GetAllChatsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class GetAllChatsUseCase {

    private let chatRepository: ChatRepositoryType

    public init(chatRepository: ChatRepositoryType) {
        self.chatRepository = chatRepository
    }

    public func build() -> Observable<[Chat]> {
        return chatRepository.observeAll().map({ $0.sorted(by: <) })
    }

}
