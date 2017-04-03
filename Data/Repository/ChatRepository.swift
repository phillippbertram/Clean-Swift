//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class ChatRepository {

    public init() {
        
    }

}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func getAllChats() -> Observable<[Chat]> {
        return Observable.just([])
    }

    public func create(chat: Chat) -> Observable<Chat> {
        return Observable.empty()
    }

}
