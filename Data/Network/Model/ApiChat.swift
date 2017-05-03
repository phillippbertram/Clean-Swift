//
//  ApiChat.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import Domain

public struct ApiChat {

    public var id: String!

    public var participant: String!

    public var messages: [ApiMessage] = []

    public var createdAt: Date!
    public var modifiedAt: Date!

}
