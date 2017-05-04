//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import Common
import RxSwift

public final class ContactRepository {

    fileprivate let localDataSource: ContactDataSourceCache
    fileprivate let networkDataSource: ContactDataSourceNetwork

    public init(localDataSource: ContactDataSourceCache,
                networkDataSource: ContactDataSourceNetwork) {
        self.localDataSource = localDataSource
        self.networkDataSource = networkDataSource
    }

}

// MARK: - ContactRepositoryType

extension ContactRepository: ContactRepositoryType {

    public func getAll() -> Single<[Contact]> {
        let local = localDataSource.getAll().asObservable().flatMapResult()
        let network = networkDataSource
                .getAll()
                .flatMap { [unowned self] in
                    self.localDataSource.persist(entities: $0)
                }
                .asObservable()
                .flatMapResult()

        return Observable
                .concat([local, network])
                .single({ $0.isSuccess && !$0.value!.isEmpty })
                .map({ $0.value! })
                .take(1)
                .asSingle()
    }

    public func getBy(userName: String) -> Single<Contact> {
        let local = localDataSource.get(byUserName: userName).asObservable().flatMapResult()
        let network = networkDataSource
                .get(byUserName: userName)
                .flatMap { [unowned self] in
                    self.localDataSource.persist(entity: $0)
                }
                .asObservable()
                .flatMapResult()

        return Observable
                .concat(local, network)
                .single({ $0.isSuccess })
                .map({ $0.value! })
                .take(1)
                .asSingle()
    }

    public func create(params: CreateContactParam) -> Single<Contact> {
        let contact = Contact(userName: params.userName, firstName: params.firstName, lastName: params.lastName)
        return localDataSource.persist(entity: contact)
    }

}
