//
// Created by Phillipp Bertram on 23.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxAlamofire

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
        return Alamofire.rx.
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
