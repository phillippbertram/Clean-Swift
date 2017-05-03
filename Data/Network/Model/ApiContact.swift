//
//  ApiContact.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import ObjectMapper

public struct ApiContact {
    public var userName: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
}

extension ApiContact: Mappable {

    public init?(map: Map) {
        self.init()

        if map.JSON["username"] == nil {
            return nil
        }
    }

    mutating public func mapping(map: Map) {
        userName <- map["username"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
    }

}
