//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift

protocol RealmDAOType {
    associatedtype Entity = BaseEntity

    func findAll() -> [Entity]

    func find(withFilter filter: (Entity) -> Bool) -> [Entity]

    func deleteAll()

}

public class RealmBaseDAO<Entity: BaseEntity> {

    private let config: Realm.Configuration

    public init(config: Realm.Configuration) {
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

    /// Finds all entities matching given filter
    ///
    /// - Parameter filter: Filter
    /// - Returns: filtered results
    func findOne(withFilter filter: (Entity) -> Bool) -> Entity? {
        return find(withFilter: filter).first
    }

    /// Finds an entity by given primary key
    ///
    /// - Parameter primaryKey: primary key
    /// - Returns: entity
    func find(byPrimaryKey primaryKey: String) -> Entity? {
        return find(withFilter:({ $0.id == primaryKey })).first
    }

    // MARK: Writing

    func write(block: @escaping (() -> [Entity])) -> Observable<[Entity]> {
        return Observable.deferred { [unowned self] in
            let realm = self.getRealm()
            do {
                realm.beginWrite()
                let entities = block()
                for entity in entities {
                    realm.add(entity, update: true)
                }
                try realm.commitWrite()
                return Observable.just(entities)
            } catch (let error) {
                return Observable.error(error)
            }
        }

    }

    func write(block: @escaping (() -> Entity)) -> Observable<Entity> {
        return Observable.deferred { [unowned self] in
            let realm = self.getRealm()
            do {
                realm.beginWrite()
                let entity = block()
                realm.add(entity, update: true)
                try realm.commitWrite()
                return Observable.just(entity)
            } catch (let error) {
                return Observable.error(error)
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
            realm.beginWrite()
            realm.delete(entity)
            try realm.commitWrite()
        } catch let error as NSError {
            log.error("Failed deleting entity: \(entity) with error: \(error)")
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

// MARK: - RemoteEntityType Extension

extension RealmBaseDAO where Entity: RemoteEntityType {

    func find(byRemoteId remoteId: String) -> Entity? {
        return findOne(withFilter: ({ $0.remoteId == remoteId }))
    }

}
