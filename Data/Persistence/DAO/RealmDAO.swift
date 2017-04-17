//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm
import Domain

protocol RealmDAOType {

    associatedtype Entity = BaseEntity

    func findAll() -> [Entity]

    func find(withFilter filter: (Entity) -> Bool) -> [Entity]

    func deleteAll()

}

public class RealmBaseDAO<Entity: BaseEntity> {

    private let config: Realm.Configuration

    // TODO: inject
    private let schedulerProvider: SchedulerProviderType = SchedulerProvider()

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

    // MARK: Observing

    func observeAll() -> Observable<[Entity]> {
        return Observable.deferred { [unowned self] () -> Observable<[Entity]> in
            let all = self.queryAll()
            return Observable.arrayWithChangeset(from: all).map({ return $0.0 })
        }
        .subscribeOn(schedulerProvider.mainScheduler)
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
                realm.refresh()
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
    func delete(entity: Entity) throws {
        let realm = getRealm()
        do {
            realm.beginWrite()
            realm.delete(entity)
            try realm.commitWrite()
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

    func find(byRemoteId remoteId: String) -> Entity? {
        return findOne(withFilter: ({ $0.remoteId == remoteId }))
    }

}
