//
// Created by Phillipp Bertram on 23.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public protocol ContactApiType {

    /// Returns all available contacts
    ///
    /// - Returns: Single
    func getAll() -> Single<[ApiContact]>

    /// Returns contact by given username
    ///
    /// - Parameter byUsername: username
    /// - Returns: Single
    func get(byUsername: String) -> Single<ApiContact>

}

public final class ContactApi: ContactApiType {

    public init() {

    }

    public func getAll() -> Single<[ApiContact]> {
        return Single.deferred {
            let c1 = ApiContact(userName: "alb", firstName: "Alexander", lastName: "Brechmann")
            let c2 = ApiContact(userName: "nih", firstName: "Nils", lastName: "Hohmann")
            return Single.just([c1, c2])
        }
    }

    public func get(byUsername userName: String) -> Single<ApiContact> {
        return getAll().map {
            if let contact = $0.filter({ $0.userName == userName }).first {
                return contact
            }
            throw ApiError.contactNotFound
        }
    }

}
