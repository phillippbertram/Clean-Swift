//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ContactDataSourceDb {

    fileprivate let contactMapper = ContactEntityDomainMapper()
    fileprivate let contactDAO: ContactDAO

    public init(contactDAO: ContactDAO) {
        self.contactDAO = contactDAO
    }

    public func persist(_ contact: Contact) -> Single<Contact> {
        return Single.deferred { [unowned self] in
                    log.debug("Creating Contact: \(contact)")
                    return self.contactDAO.write { _ -> ContactEntity in
                        return self.mapContactToEntity(contact)
                    }
                }
                .map { [unowned self] in
                    self.contactMapper.map($0)
                }
    }

    public func persistAll(_ contacts: [Contact]) -> Single<[Contact]> {
        return Single.deferred { [unowned self] in
                    log.debug("Creating Contacts: \(contacts)")
                    return self.contactDAO.write { _ -> [ContactEntity] in
                        return contacts.map { [unowned self] contact -> ContactEntity in
                            self.mapContactToEntity(contact)
                        }
                    }
                }
                .map { [unowned self] in
                    self.contactMapper.mapAll($0)
                }
    }

}

// MARK: - ContactDataSource

extension ContactDataSourceDb: ContactDataSource {

    func getAll() -> Single<[Contact]> {
        return Single.deferred { [unowned self] () -> Single<[Contact]> in
            let contacts = self.contactDAO.findAll()
            return Single.just(contacts)
                    .map { [unowned self] in
                        self.mapAll($0)
                    }
        }
    }

    func get(byUserName userName: String) -> Single<Contact> {
        return Single.deferred { [unowned self] in
                    guard let contact = self.contactDAO.find(byUserName: userName) else {
                        throw DataSourceError.contactNotFound
                    }
                    return Single.just(contact)
                }
                .map { [unowned self] contactEntity in
                    return self.mapContact(contactEntity)
                }
    }

}

// MARK: - Mapping

private extension ContactDataSourceDb {

    func mapAll(_ contactEntities: [ContactEntity]) -> [Contact] {
        return contactEntities.map { [unowned self] contactEntity in
            self.mapContact(contactEntity)
        }
    }

    func mapContact(_ contactEntity: ContactEntity) -> Contact {
        return contactMapper.map(contactEntity)

    }

    func mapContactToEntity(_ contact: Contact) -> ContactEntity {
        let entity = ContactEntity()
        entity.userName = contact.userName
        entity.firstName = contact.firstName
        entity.lastName = contact.lastName
        return entity
    }

}
