//
// Created by Phillipp Bertram on 20.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import ObjectMapper
import Domain

extension MessageDTO: Mappable {

    public init?(map: Map) {
        self.init()

        if map.JSON["id"] == nil {
            return nil
        }
        if map.JSON["chatId"] == nil {
            return nil
        }
        if map.JSON["content"] == nil {
            return nil
        }
        if map.JSON["status"] == nil {
            return nil
        }
        if map.JSON["sender"] == nil {
            return nil
        }
        if map.JSON["status"] == nil {
            return nil
        }
        if map.JSON["timestamp"] == nil {
            return nil
        }
    }

    mutating public func mapping(map: Map) {
        id <- map["id"]
        chatId <- map["chatId"]
        content <- map["content"]
        status <- map["status"]
        sender <- map["sender"]
        timestamp <- (map["timestamp"], DateTransform())
    }

}
