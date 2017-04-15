//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

public final class ContactEntity: RemoteEntity {

    dynamic var firstName: String = ""
    dynamic var lastName: String = ""

    convenience init(userName: String) {
        self.init()
        self.id = userName
    }

    var userName: String {
        get {
            return id
        }
        set {
            self.id = newValue
        }
    }

}
