//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ContactRepository {

    fileprivate let contactMapper = ContactEntityDomainMapper()

    fileprivate let contactDao: ContactDAO

    public init(contactDao: ContactDAO) {
        self.contactDao = contactDao
    }

}

// MARK: - ContactRepositoryType

extension ContactRepository: ContactRepositoryType {

    public func getAll() -> Single<[Contact]> {
        return Single.deferred { [unowned self] in
            let contacts = self.contactDao
                    .findAll()
            return Single.just(contacts)
        }.map {
            self.mapAll($0)
        }
    }

    public func getBy(userName: String) -> Single<Contact> {
        return Single.deferred { [unowned self] in
            let contact = self.contactDao.find(byUserName: userName)
            return Single.just(contact!)
        }
        .map { [unowned self] contactEntity in
            return self.mapContact(contactEntity)
        }
    }

    public func create(params: CreateContactParam) -> Single<Contact> {
        return Observable.deferred { [unowned self] in
            log.debug("Creating Contact: \(params)")
            return self.contactDao.write { () -> ContactEntity in
                let entity = ContactEntity()
                entity.userName = params.userName
                entity.firstName = params.firstName
                entity.lastName = params.lastName
                return entity
            }
        }.map { [unowned self] in
            self.contactMapper.map($0)
        }.asSingle()
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
