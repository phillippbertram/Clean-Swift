//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

final class Seeder {

    fileprivate let contactRepo: ContactRepositoryType

    init(contactRepo: ContactRepositoryType) {
        self.contactRepo = contactRepo
    }

    func seedData() -> Observable<Void> {
        return createContacts()
    }

    private func createContacts() -> Observable<Void> {
        let c1 = contactRepo.create(contact: Contact(userName: "pbe", firstName: "Phillipp", lastName: "Bertram"))
        let c2 = contactRepo.create(contact: Contact(userName: "alb", firstName: "Alexander", lastName: "Brechmann"))

        return Observable.concat(c1, c2).toArray().map({ _ in () })
    }

}
