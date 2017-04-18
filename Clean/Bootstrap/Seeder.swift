//
// Created by Phillipp Bertram on 17.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

// swiftlint:disable line_length
final class Seeder {

    fileprivate let createContactUseCase: CreateContactUseCase

    init(createContactUseCase: CreateContactUseCase) {
        self.createContactUseCase = createContactUseCase
    }

    func seedData() -> Observable<Void> {
        return createContacts()
    }

    private func createContacts() -> Observable<Void> {
        let c1 = createContactUseCase.build(CreateContactParam(userName: "pbe", firstName: "Phillipp", lastName: "Bertram"))
        let c2 = createContactUseCase.build(CreateContactParam(userName: "alb", firstName: "Alexander", lastName: "Brechmann"))

        return Observable.concat(c1, c2).toArray().map({ _ in () })
    }

}
