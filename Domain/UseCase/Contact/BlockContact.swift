//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

final class BlockContactUseCase: UseCase<Contact, Void> {

    fileprivate let contactRepository: ContactRepositoryType

    init(schedulerProvider: SchedulerProviderType,
         contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Contact) -> Observable<Void> {
        return Observable.empty()
    }

}
