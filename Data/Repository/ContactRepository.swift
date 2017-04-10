//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class ContactRepository {

    fileprivate var data: [String: Contact] = [:]

    fileprivate let contactService: ContactServiceType

    public init(contactService: ContactServiceType) {
        self.contactService = contactService
    }

    fileprivate func addContact(_ contact: Contact) {
        data[contact.userName] = contact
    }

    fileprivate func importContact(_ contact: Contact) -> Observable<Contact> {
        return importContacts([contact]).map({ $0.first! })
    }

    fileprivate func importContacts(_ contacts: [Contact]) -> Observable<[Contact]> {
        return Observable.deferred {
            for contact in contacts {
                self.addContact(contact)
            }
            return Observable.just(contacts)
        }
    }

}

// MARK: - ContactRepositoryType

extension ContactRepository: ContactRepositoryType {

    public func getAll() -> Observable<[Contact]> {
        return contactService
                .getContacts()
                .flatMap(importContacts)
    }

    public func getBy(userName: String) -> Observable<Contact> {
        return Observable.deferred {
            if let contact = self.data[userName] {
                return Observable.just(contact)
            }

            return self.contactService
                    .getContact(byUserName: userName)
                    .flatMap(self.importContact)
        }
    }

}
