//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

public final class MessageEntity: RemoteEntity {

    enum Status: String {
        case sending, sent, failed, delivered
    }

    dynamic var message: String = ""
    dynamic var isIncoming: Bool = true
    dynamic var isRead: Bool = true

    dynamic var senderId: String!
    dynamic var chat: ChatEntity!

    private dynamic var rawStatus: String = Status.sent.rawValue
    var status: Status {
        get {
            return Status(rawValue: rawStatus)!
        }
        set {
            self.rawStatus = newValue.rawValue
        }
    }

    convenience init(senderId: String, chat: ChatEntity) {
        self.init()
        self.senderId = senderId
        self.chat = chat
    }

}
