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

final class ChatService: ChatServiceType {

    private let chatAPI: ChatAPI
    private let contactAPI: ContactAPI

    init(chatAPI: ChatAPI, contactAPI: ContactAPI) {
        self.chatAPI = chatAPI
        self.contactAPI = contactAPI
    }

    func getChats() -> Observable<[Chat]> {
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

    private func map(chatDTO: ChatDTO, participant: ContactDTO) -> Chat {
        let participant = map(contactDTO: participant)
        return Chat(participant: participant)
    }

    private func map(contactDTO: ContactDTO) -> Contact {
        return Contact(firstName: contactDTO.firstName,
                       lastName: contactDTO.lastName)
    }

}
