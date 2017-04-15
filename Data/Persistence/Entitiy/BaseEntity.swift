//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

class BaseEntity: Object {

    dynamic var id: String = UUID().uuidString

    dynamic var createdAt: Date = Date()

    override class func primaryKey() -> String? {
        return "id"
    }

}
