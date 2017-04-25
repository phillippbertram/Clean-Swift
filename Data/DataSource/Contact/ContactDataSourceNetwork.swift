//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxSwiftExt

public final class ContactDataSourceNetwork {

    private let maxAttempts: UInt = 3
    private let retryDelay: TimeInterval = 0.3

    fileprivate let contactApi: ContactApiType

    public init(contactApi: ContactApiType) {
        self.contactApi = contactApi
    }

    fileprivate func requestPolicy<E>(_ request: Observable<E>) -> Observable<E> {
        return request
                .retry(RepeatBehavior.delayed(maxCount: maxAttempts, time: retryDelay))
                .delay(4, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

// MARK: - ContactDataSource

extension ContactDataSourceNetwork: ContactDataSource {

    func get(byUserName userName: String) -> Single<Contact> {
        return contactApi
                .get(byUsername: userName)
                .asObservable()
                .map(Contact.init)
                .apply(requestPolicy)
                .asSingle()
    }

    func getAll() -> Single<[Contact]> {
        return contactApi
                .getAll()
                .asObservable()
                .flatMap({ Observable.from($0) })
                .map(Contact.init)
                .apply(requestPolicy)
                .toArray()
                .asSingle()
    }

}

extension Contact {

    init(contactDTO: ApiContact) {
        self.userName = contactDTO.userName
        self.firstName = contactDTO.firstName
        self.lastName = contactDTO.lastName
    }

}
