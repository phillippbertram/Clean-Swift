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

public final class ContactApi: BaseApi<ApiContact>, ContactApiType {

    public init() {
        super.init("http://localhost:3000")
    }

    public func getAll() -> Single<[ApiContact]> {
        return getItems("contacts")
    }

    public func get(byUsername userName: String) -> Single<ApiContact> {
        return getItem("contacts", itemId: userName)
    }

}
