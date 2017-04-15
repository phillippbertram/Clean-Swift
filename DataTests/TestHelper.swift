//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

extension Realm.Configuration {

    static func test(withName name: String?) -> Realm.Configuration {
        let memoryIdentifier = name ?? "Test"
        return Realm.Configuration(fileURL: nil,
                                   inMemoryIdentifier: memoryIdentifier,
                                   syncConfiguration: nil,
                                   encryptionKey: nil,
                                   readOnly: false,
                                   schemaVersion: 0,
                                   migrationBlock: nil,
                                   deleteRealmIfMigrationNeeded: true,
                                   objectTypes: nil)
    }

}
