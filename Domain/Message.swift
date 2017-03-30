//
//  Message.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation

public struct Message {
    
    public enum `Type` {
        case text(String)
        case image(Data)
    }
    
    public var sender: Contact
    public var type: Type
    public var isIncoming: Bool
    public var timestamp: Date
    
}
