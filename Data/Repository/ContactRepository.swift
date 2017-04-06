//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift

public final class ContactRepository {

    fileprivate var data: [String: Contact] = [:]

    public init() {
        let pbe = Contact(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        let alb = Contact(userName: "alb", firstName: "Alexander", lastName: "Brechmann")
        let waw = Contact(userName: "waw", firstName: "Waldemar", lastName: "Weißhaar")
        let nih = Contact(userName: "nih", firstName: "Nils", lastName: "Hohmann")
        let cwo = Contact(userName: "cwo", firstName: "Christof", lastName: "Wolke")
        let mdr = Contact(userName: "mdr", firstName: "Matthias", lastName: "Dierker")
        addContact(pbe)
        addContact(alb)
        addContact(waw)
        addContact(nih)
        addContact(cwo)
        addContact(mdr)
    }

    private func addContact(_ contact: Contact) {
        data[contact.userName] = contact
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
