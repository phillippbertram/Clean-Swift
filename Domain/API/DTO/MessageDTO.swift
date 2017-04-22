//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public struct MessageDTO {

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

extension MessageDTO {

    public var messageStatus: MessageDTO.Status {
        get {
            return Status.fromString(status)
        }
        set {
            status = newValue.rawValue
        }
    }
}

extension Message.Status {

    init(status: MessageDTO.Status) {
        switch status {
            case .sent, .unknown:
                self = .sent
            case .delivered:
                self = .delivered
        }
    }

}
