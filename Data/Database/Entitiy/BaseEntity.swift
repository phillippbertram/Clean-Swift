//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

public class BaseEntity: Object {

    dynamic var id: String = UUID().uuidString

    dynamic var createdAt: Date = Date()
    dynamic var modifiedAt: Date = Date()

    public override class func primaryKey() -> String? {
        return "id"
    }

}
