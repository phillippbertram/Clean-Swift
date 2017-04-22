//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ImportApiContactsUseCase: SingleUseCase<[ContactDTO], [Contact]> {

    private let contactRepository: ContactRepositoryType

    init(schedulerProvider: SchedulerProviderType,
         contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params contactDTOs: [ContactDTO]) -> Single<[Contact]> {
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
