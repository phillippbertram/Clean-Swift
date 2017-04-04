//
// Created by Phillipp Bertram on 31/03/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RealmSwift

final class ChatDao: RealmBaseDao<ChatEntity> {

    func getChats() -> [ChatEntity] {
        let realm = getRealm()
        let results = realm.objects(ChatEntity.self)
        return Array(results)
    }

}
