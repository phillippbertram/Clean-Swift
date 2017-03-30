//
//  Chat.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct Chat {
    
    public var participant: Contact
    public var lastMessage: Message?
    
    public init(participant: Contact) {
        self.participant = participant
    }
    
}
