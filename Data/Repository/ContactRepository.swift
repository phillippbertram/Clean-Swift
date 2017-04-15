//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ContactRepository {

    fileprivate let contactDao: ContactDAO

    public init(contactDao: ContactDAO) {
        self.contactDao = contactDao
    }

}

// MARK: - ContactRepositoryType

extension ContactRepository: ContactRepositoryType {

    public func getAll() -> Observable<[Contact]> {
        return Observable.deferred { [unowned self] in
            let contacts = self.contactDao
                    .findAll()
            return Observable.just(contacts)
        }.map {
            self.mapAll($0)
        }
    }

    public func getBy(userName: String) -> Observable<Contact> {
        return Observable.deferred { [unowned self] in
            let contact = self.contactDao.find(byUserName: userName)
            return Observable.just(contact!)
        }.map { [unowned self] contactEntity in
            return self.mapContact(contactEntity)
        }
    }

    public func create(contact: Contact) -> Observable<Contact> {
        fatalError("not implemented")
    }

}

// MARK: - Mapping

extension ContactRepository {

    func mapAll(_ contactEntities: [ContactEntity]) -> [Contact] {
        return contactEntities.map { [unowned self] contactEntity in
            self.mapContact(contactEntity)
        }
    }

    func mapContact(_ contactEntity: ContactEntity) -> Contact {
        return Contact(userName: contactEntity.userName,
                       firstName: contactEntity.firstName,
                       lastName: contactEntity.lastName)

    }

}
