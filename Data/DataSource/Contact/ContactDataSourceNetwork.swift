//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxSwiftExt

public final class ContactDataSourceNetwork {

    fileprivate let apiContactMapper: ApiContactDomainMapper = ApiContactDomainMapper()
    fileprivate let contactApi: ContactApiType

    public init(contactApi: ContactApiType) {
        self.contactApi = contactApi
    }
}

// MARK: - ContactDataSource

extension ContactDataSourceNetwork: ContactDataSource {

    func get(byUserName userName: String) -> Single<Contact> {
        return contactApi
                .get(byUsername: userName)
                .asObservable()
                .map(apiContactMapper.map)
                .asSingle()
    }

    func getAll() -> Single<[Contact]> {
        return contactApi
                .getAll()
                .asObservable()
                .map(apiContactMapper.mapAll)
                .asSingle()
    }

}
