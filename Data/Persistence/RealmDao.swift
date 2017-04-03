//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RealmSwift

class RealmBaseDao<Entity:Object> {

    private let config: Realm.Configuration

    init(config: Realm.Configuration) {
        self.config = config
    }

    func getRealm() -> Realm {
        return try! Realm(configuration: config)
    }

    func findAll() -> [Entity] {
        let realm = getRealm()
        let entities = realm.objects(Entity.self)
        return Array(entities)
    }

    func delete(d: Entity) {
        let realm = getRealm()
        do {
            try getRealm().write {
                realm.delete(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

    func deleteAll() {
        let realm = getRealm()
        let entities = realm.objects(Entity.self)
        do {
            try realm.write {
                realm.delete(entities)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

}
