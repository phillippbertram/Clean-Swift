//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

// MARK: - DataSourceCache

public class DataSourceCache<Entity: Hashable> {

    fileprivate var data: Set<Entity> = []

    fileprivate let publishSubject = PublishSubject<[Entity]>()

    public init() {

    }

    public func persist(entities: [Entity]) -> Single<[Entity]> {
        return Single.deferred { [unowned self] in
            for entity in entities {
                self.data.insert(entity)
            }
            self.publishSubject.onNext(Array(self.data))
            return Single.just(entities)
        }
    }

    public func persist(entity: Entity) -> Single<Entity> {
        return Single.deferred { [unowned self] in
            self.data.insert(entity)
            self.publishSubject.onNext(Array(self.data))
            return Single.just(entity)
        }
    }

    public func observeAll() -> Observable<[Entity]> {
        return publishSubject
    }

    public func get(byFilter filter: @escaping (Entity) -> (Bool)) -> Single<[Entity]> {
        return Single.deferred { [unowned self] in
            let result = self.data.filter(filter)
            return Single.just(result)
        }
    }

}

extension DataSourceCache: DataSource {

    public func getAll() -> Single<[Entity]> {
        return Single.just(Array(data))
    }

}

extension DataSourceCache where Entity: Identifiable {

    func get(byId id: String) -> Single<Entity> {
        return getAll().map { entities in
            entities.filter({ $0.id == id }).first!
        }
    }
}
