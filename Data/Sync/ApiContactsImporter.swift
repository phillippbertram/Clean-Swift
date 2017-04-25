//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class ApiContactsImporter {

    private let contactRepository: ContactRepositoryType

    public init(contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
    }

    func build(params contactDTOs: [ApiContact]) -> Single<[Contact]> {
        return Observable
                .from(contactDTOs)
                .map { contactDTO in
                    CreateContactParam(userName: contactDTO.userName,
                                       firstName: contactDTO.firstName,
                                       lastName: contactDTO.lastName)
                }
                .flatMap { [unowned self] in
                    self.contactRepository.create(params: $0)
                }
                .toArray()
                .asSingle()
    }

}
