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

    dynamic var sender: ContactEntity!
    dynamic var chat: ChatEntity!

    private dynamic var rawStatus: String = Status.sent.rawValue
    var status: Status {
        get {
            return Status(rawValue: rawStatus)!
        }
        set {
            self.rawStatus = status.rawValue
        }
    }

    convenience init(sender: ContactEntity, chat: ChatEntity) {
        self.init()
        self.sender = sender
        self.chat = chat
    }

}
