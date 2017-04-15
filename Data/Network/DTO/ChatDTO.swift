//
//  ChatDTO.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import Domain

struct ChatDTO {

    let id: String

    let initiator: String
    let receiver: String

    let messages: [MessageDTO]

    let createdAt: Date
    let modifiedAt: Date

}

extension ChatDTO {

    func participantName(currentUser: CurrentUser) -> String {
        if initiator == currentUser.userName {
            return receiver
        }
        return initiator
    }

}
