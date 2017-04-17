//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import Domain

extension Message.Status {

    static func from(_ entityStatus: MessageEntity.Status) -> Message.Status {
        switch entityStatus {
            case .sending:
                return .sending
            case .failed:
                return .failure
            case .sent:
                return .sent
            case .delivered:
                return .delivered
        }
    }

}

extension MessageEntity.Status {

    static func from(_ status: Message.Status) -> MessageEntity.Status {
        switch status {
            case .sending:
                return .sending
            case .failure:
                return .failed
            case .sent:
                return .sent
        case .delivered:
            return .delivered
        }
    }

}

final class MessageEntityDomainMapper {

    private let contactMapper = ContactEntityDomainMapper()

    func map(_ entity: MessageEntity) -> Message {
        return Message(id: entity.id,
                       chatId: entity.chat.id,
                       content: .text(entity.message),
                       status: Message.Status.from(entity.status),
                       sender: contactMapper.map(entity.sender),
                       isIncoming: entity.isIncoming,
                       isRead: entity.isRead,
                       timestamp: entity.createdAt)
    }

    func mapAll(_ entities: [MessageEntity]) -> [Message] {
        return entities.map(map)
    }

}
