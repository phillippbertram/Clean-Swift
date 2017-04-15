//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

class RealmBaseDao<Entity: BaseEntity> {

    private let config: Realm.Configuration

    init(config: Realm.Configuration) {
        self.config = config
    }

    /// Returns a realm instance
    ///
    /// - Returns: realm
    func getRealm() -> Realm {
        // swiftlint:disable:next force_try
        return try! Realm(configuration: config)
    }

    // MARK: Query

    func queryAll() -> Results<Entity> {
        return getRealm().objects(Entity.self)
    }

    func query(withFilter predicate: NSPredicate) -> Results<Entity> {
        return queryAll().filter(predicate)
    }

    // MARK: Reading

    /// Finds all entities
    ///
    /// - Returns: all entities for generic type
    func findAll() -> [Entity] {
        let entities = queryAll()
        return Array(entities)
    }

    /// Finds all entities matching given filter
    ///
    /// - Parameter filter: Filter
    /// - Returns: filtered results
    func find(withFilter filter: (Entity) -> Bool) -> [Entity] {
        return queryAll().filter(filter)
    }

    /// Finds an entity by given primary key
    ///
    /// - Parameter primaryKey: primary key
    /// - Returns: entity
    func find(byPrimaryKey primaryKey: String) -> Entity? {
        return find(withFilter:({ $0.id == primaryKey })).first
    }

    // MARK: Writing

    func write(block: @escaping (() -> [Entity])) {
        let realm = getRealm()
        // swiftlint:disable:next force_try
        return try! realm.write { [unowned realm] in
            let entities = block()
            for entity in entities {
                realm.add(entity, update: true)
            }
        }
    }

    // MARK: Deleting

    /// Deletes given entity
    ///
    /// - Parameter entity: entity
    func delete(entity: Entity) {
        let realm = getRealm()
        do {
            try getRealm().write {
                realm.delete(entity)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

    /// Deletes an entity for primary key
    ///
    /// - Parameter primaryKey: Primary Key
    func delete(byId primaryKey: String) {
        let realm = getRealm()
        do {
            try realm.write { [unowned self, unowned realm] in
                if let entity = self.find(byPrimaryKey: primaryKey) {
                    realm.delete(entity)
                }
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

    /// Deletes all entities for generic type
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
