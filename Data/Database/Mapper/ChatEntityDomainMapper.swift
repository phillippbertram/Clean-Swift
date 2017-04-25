//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import Domain

final class ChatEntityDomainMapper {

    private let contactMapper = ContactEntityDomainMapper()

    func map(_ entity: ChatEntity) -> Chat {
        return Chat(id: entity.id,
                    participant: contactMapper.map(entity.participant),
                    lastMessage: nil,
                    modifiedAt: entity.modifiedAt,
                    createdAt: entity.createdAt)
    }

    func mapAll(_ entities: [ChatEntity]) -> [Chat] {
        return entities.map(self.map)
    }

}
