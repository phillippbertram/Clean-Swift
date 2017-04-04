//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class ContactRepository {

    fileprivate var data: [String: Contact] = [:]

    public init() {

    }

}

// MARK: - ContactRepositoryType

extension ContactRepository: ContactRepositoryType {

    public func getAllContacts() -> Observable<[Contact]> {
        return Observable.deferred {
            return Observable.just(Array(self.data.values))
        }
    }

}
