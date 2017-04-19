//
// Created by Phillipp Bertram on 18.04.17.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class CreateContactUseCase: SingleUseCase<CreateContactParam, Contact> {

    private let contactRepository: ContactRepositoryType

    public init(schedulerProvider: SchedulerProviderType,
                contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: CreateContactParam) -> Single<Contact> {
        return contactRepository.create(params: params)
    }

}
