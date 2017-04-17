//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Data
import RealmSwift

final class DataBaseLogger {

    fileprivate let realmConfig: Realm.Configuration

    init(realmConfig: Realm.Configuration) {
        self.realmConfig = realmConfig
    }

    func logAll() {
        // swiftlint:disable:next force_try
        let realm = try! Realm(configuration: realmConfig)
        let allContacts = realm.objects(ContactEntity.self)
        let allChats = realm.objects(ChatEntity.self)
        let allMessages = realm.objects(MessageEntity.self)

        log.verbose("All Contacts: \(allContacts)")
        log.verbose("All Chats: \(allChats)")
        log.verbose("All Chats: \(allMessages)")
    }

}
