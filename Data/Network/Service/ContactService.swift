//
// Created by Phillipp Bertram on 10/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift
import Domain

public final class ContactService {

    fileprivate let contactAPI: ContactAPI

    public init(contactAPI: ContactAPI) {
        self.contactAPI = contactAPI
    }

}

// MARK: - ContactServiceType

extension ContactService: ContactServiceType {

    /// Gets all available contacts.
    ///
    /// - Returns: Observable
    public func getContacts() -> Observable<[Contact]> {
        return contactAPI.getAll().map(mapAll)
    }

    /// Gets a contact by given user name.
    ///
    /// - Parameter userName: The user name.
    /// - Returns: Observable
    public func getContact(byUserName userName: String) -> Observable<Contact> {
        return contactAPI.get(byId: userName).map(map)
    }

}

// MARK: - Mapping

fileprivate extension ContactService {

    func mapAll(_ dtos: [ContactDTO]) -> [Contact] {
        return dtos.map(map)
    }

    func map(_ dto: ContactDTO) -> Contact {
        return Contact(userName: dto.userName,
                       firstName: dto.firstName,
                       lastName: dto.lastName)
    }

}
