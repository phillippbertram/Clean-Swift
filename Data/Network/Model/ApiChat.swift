//
//  ApiChat.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import ObjectMapper
import Domain

public struct ApiChat {

    fileprivate(set) public var id: String!

    fileprivate(set) public var participant: String!

    fileprivate(set) public var messages: [ApiMessage] = []

    fileprivate(set) public var createdAt: Date = Date()
    fileprivate(set) public var modifiedAt: Date = Date()

}

// MARK: - Mappable

extension ApiChat: Mappable {

    public init?(map: Map) {

        if map.JSON["id"] == nil {
            return nil
        }

        if map.JSON["participant"] == nil {
            return nil
        }

    }

    public mutating func mapping(map: Map) {
        id <- map["id"]
        participant <- map["participant"]
        messages <- map["messages"]
        createdAt <- map["createdAt"]
        modifiedAt <- map["modifiedAt"]
    }

}
