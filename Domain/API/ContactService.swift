//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

protocol ContactServiceType {

    /// Returns all available contacts
    ///
    /// - Returns: Single
    func getAll() -> Single<[ContactDTO]>

    /// Returns contact by given username
    ///
    /// - Parameter byUsername: username
    /// - Returns: Single
    func get(byUsername: String) -> Single<ContactDTO>

}
