//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm
import Domain

enum RealmError: Error {
    case entityNotFound
}

public class RealmBaseDAO<Entity:BaseEntity> {

    private let config: Realm.Configuration

    // TODO: inject
    private let schedulerProvider: SchedulerProviderType = SchedulerProvider()

    public init(config: Realm.Configuration) {
        self.config = config
    }

    /// Returns a realm instance
    ///
    /// - Returns: realm
    func getRealm(_ realm: Realm? = nil) -> Realm {
        if let realm = realm {
            return realm
        }
        // swiftlint:disable:next force_try
        return try! Realm(configuration: config)
    }

    // MARK: Query

    func queryAll(realm: Realm? = nil) -> Results<Entity> {
        return getRealm(realm).objects(Entity.self)
    }

    func query(realm: Realm? = nil, withFilter predicate: NSPredicate) -> Results<Entity> {
        return queryAll(realm: realm).filter(predicate)
    }

    // MARK: Reading

    /// Finds all entities
    ///
    /// - Returns: all entities for generic type
    func findAll(realm: Realm? = nil) -> [Entity] {
        let entities = queryAll(realm: realm)
        return Array(entities)
    }

    /// Finds all entities matching given filter
    ///
    /// - Parameter filter: Filter
    /// - Returns: filtered results
    func find(realm: Realm? = nil, withFilter filter: (Entity) -> Bool) -> [Entity] {
        return queryAll(realm: realm).filter(filter)
    }

    /// Finds all entities matching given filter
    ///
    /// - Parameter filter: Filter
    /// - Returns: filtered results
    func findOne(realm: Realm? = nil, withFilter filter: (Entity) -> Bool) -> Entity? {
        return find(realm: realm, withFilter: filter).first
    }

    /// Finds an entity by given primary key
    ///
    /// - Parameter primaryKey: primary key
    /// - Returns: entity
    func find(realm: Realm? = nil, byPrimaryKey primaryKey: String) -> Entity? {
        return find(realm: realm, withFilter: ({ $0.id == primaryKey })).first
    }

    // MARK: Observing

    func observeAll() -> Observable<[Entity]> {
        return Observable.deferred { [unowned self] () -> Observable<[Entity]> in
                    let all = self.queryAll()
                    return Observable.arrayWithChangeset(from: all).map({ return $0.0 })
                }
                .subscribeOn(schedulerProvider.mainScheduler)
                .observeOn(schedulerProvider.mainScheduler)
    }

    func observe(byFilter predicate: NSPredicate) -> Observable<[Entity]> {
        return Observable.deferred { [unowned self] () -> Observable<[Entity]> in
                    let all = self.query(withFilter: predicate)
                    return Observable.arrayWithChangeset(from: all).map({ return $0.0 })
                }
                .subscribeOn(schedulerProvider.mainScheduler)
                .observeOn(schedulerProvider.mainScheduler)
    }

    // MARK: Writing

    func write(block: @escaping ((Realm) throws -> [Entity])) -> Single<[Entity]> {
        return Single.deferred { [unowned self] in
            let realm = self.getRealm()
            do {
                realm.beginWrite()
                let entities = try block(realm)
                for entity in entities {
                    realm.add(entity, update: true)
                }
                try realm.commitWrite()
                realm.refresh()
                return Single.just(entities)
            } catch (let error) {
                return Single.error(error)
            }
        }

    }

    func write(realm: Realm? = nil, block: @escaping ((Realm) throws -> Entity)) -> Single<Entity> {
        return Single.deferred { [unowned self] in
            let realm = self.getRealm(realm)
            do {
                realm.beginWrite()
                let entity = try block(realm)
                realm.add(entity, update: true)
                try realm.commitWrite()
                return Single.just(entity)
            } catch (let error) {
                return Single.error(error)
            }
        }
    }

    func update(realm: Realm? = nil, primaryKey: String, block: @escaping ((Entity) throws -> Entity)) -> Single<Entity> {
        return Single.deferred { [unowned self] in
            let realm = self.getRealm(realm)
            do {
                realm.beginWrite()
                guard let existing = self.find(byPrimaryKey: primaryKey) else {
                    throw RealmError.entityNotFound
                }
                let entity = try block(existing)
                realm.add(entity, update: true)
                try realm.commitWrite()
                return Single.just(entity)
            } catch (let error) {
                return Single.error(error)
            }
        }
    }

    // MARK: Deleting

    /// Deletes given entity
    ///
    /// - Parameter entity: entity
    func delete(entity: Entity) throws {
        let realm = getRealm()
        do {
            var shouldCommit = false
            if !realm.isInWriteTransaction {
                realm.beginWrite()
                shouldCommit = true
            }
            realm.delete(entity)

            if shouldCommit {
                try realm.commitWrite()
            }
        } catch let error as NSError {
            log.error("error deleting entity: \(error)")
            throw error
        }
    }

    /// Deletes an entity for primary key
    ///
    /// - Parameter primaryKey: Primary Key
    func delete(byId primaryKey: String) throws {
        if let entity = self.find(byPrimaryKey: primaryKey) {
            try self.delete(entity: entity)
        }
    }

    func deleteAll(filter: @escaping (Entity) -> Bool) throws {
        let realm = getRealm()
        do {
            try realm.write { [unowned self] in
                let entities = self.find(withFilter: filter)
                realm.delete(entities)
            }
        } catch let error as NSError {
            log.error("error deleting entity: \(error)")
            throw error
        }
    }

    /// Deletes all entities for generic type
    func deleteAll() throws {
        let realm = getRealm()
        let entities = realm.objects(Entity.self)
        do {
            try realm.write {
                realm.delete(entities)
            }
        } catch let error as NSError {
            log.error("error deleting entity: \(error)")
            throw error
        }
    }

}

// MARK: - RemoteEntityType Extension

extension RealmBaseDAO where Entity: RemoteEntityType {

    func find(realm: Realm? = nil, byRemoteId remoteId: String) -> Entity? {
        return findOne(realm: realm, withFilter: ({ $0.remoteId == remoteId }))
    }

}
