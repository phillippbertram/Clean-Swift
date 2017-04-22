//
//  ChatDTO.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct ChatDTO {

    public var id: String!

    public var initiator: String!
    public var receiver: String!

    public var messages: [MessageDTO] = []

    public var createdAt: Date!
    public var modifiedAt: Date!

}

extension ChatDTO {

    func participantName(currentUser: CurrentUser) -> String {
        if initiator == currentUser.userName {
            return receiver
        }
        return initiator
    }

}
