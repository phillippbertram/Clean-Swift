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
        let contact1 = Contact(firstName: "Phillipp", lastName: "Phillipp")
        let chat1 = Chat(participant: contact1)
        return Observable.just([chat1])
    }
    
    public func create(chat: Chat) -> Observable<Chat> {
        return Observable.empty()
    }
    
}
