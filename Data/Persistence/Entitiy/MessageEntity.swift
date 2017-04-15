//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

final class MessageEntity: BaseEntity {

    enum Status: String {
        case sending, sent, failed
    }

    dynamic var message: String = ""
    dynamic var sender: ContactEntity?

    private dynamic var rawStatus: String = Status.sent.rawValue
    var status: Status {
        get {
            return Status(rawValue: rawStatus)!
        }
        set {
            self.rawStatus = status.rawValue
        }
    }

}
