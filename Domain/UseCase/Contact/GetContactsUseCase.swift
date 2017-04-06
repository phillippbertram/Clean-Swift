//
//  GetContactsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class GetContactsUseCase: UseCase<Void, [Contact]> {

    private let contactRepository: ContactRepositoryType

    public init(schedulerProvider: SchedulerProviderType, contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public func buildObservable() -> Observable<[Contact]> {
        return contactRepository.getAllContacts()
    }

}
