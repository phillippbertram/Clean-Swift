//
//  File.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class ChatService {

    fileprivate let chatAPI: ChatAPI
    fileprivate let contactAPI: ContactAPI

    public init(chatAPI: ChatAPI, contactAPI: ContactAPI) {
        self.chatAPI = chatAPI
        self.contactAPI = contactAPI
    }

    fileprivate func map(chatDTO: ChatDTO, participant: ContactDTO) -> Chat {
        let participant = map(contactDTO: participant)
        return Chat(
            id: chatDTO.id,
            participant: participant,
            lastMessage: nil,
            lastModifiedAt: Date(),
            createdAt: Date())
    }

    fileprivate func map(contactDTO: ContactDTO) -> Contact {
        return Contact(userName: contactDTO.userName,
                       firstName: contactDTO.firstName,
                       lastName: contactDTO.lastName)
    }

}

// MARK: - ChatServiceType

extension ChatService: ChatServiceType {

    public func getChats() -> Observable<[Chat]> {
        return chatAPI
                .getChats()
                .flatMap { chatDTOs in
                    return Observable.from(chatDTOs)
                }
                .flatMap { chatDTO -> Observable<(ChatDTO, ContactDTO)> in
                    return self.contactAPI
                            .getContact(byId: chatDTO.initiator)
                            .map({ (chatDTO, $0) })
                }
                .map(map)
                .toArray()
    }

}
