//
// Created by Phillipp Bertram on 15/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

public final class ContactDAO: RealmBaseDAO<ContactEntity> {

    func find(byUserName userName: String) -> ContactEntity? {
        return findOne(withFilter: ({ $0.userName == userName }))
    }

}
