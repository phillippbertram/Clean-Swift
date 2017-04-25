//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import ObjectMapper
import Domain

public struct ApiMessage {

    public enum Status: String {
        case sent = "SENT"
        case delivered = "DELIVERED"
        case unknown = "UNKNOWN"

        static func fromString(_ raw: String) -> Status {
            guard let status = Status(rawValue: raw) else {
                return .unknown
            }
            return status
        }
    }

    public var id: String!
    public var chatId: String!

    public var content: String!
    public var status: String!

    public var sender: String!

    public var timestamp: Date!

    public init() {

    }

}

extension ApiMessage {

    public var messageStatus: ApiMessage.Status {
        get {
            return Status.fromString(status)
        }
        set {
            status = newValue.rawValue
        }
    }
}

extension ApiMessage: Mappable {

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

extension Message.Status {

    init(status: ApiMessage.Status) {
        switch status {
            case .sent, .unknown:
                self = .sent
            case .delivered:
                self = .delivered
        }
    }

}
