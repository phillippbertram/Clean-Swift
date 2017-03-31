//
//  GetContactsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class GetContactsUseCase {

    private let contactRepository: ContactRepositoryType

    init(contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
    }

    public func build() -> Observable<[Contact]> {
        return contactRepository.getAllContacts()
    }

}
