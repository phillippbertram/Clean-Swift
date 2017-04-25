//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Common
import RxSwift

final class BlockContactUseCase: CompletableUseCase<Contact> {

    fileprivate let contactRepository: ContactRepositoryType

    init(schedulerProvider: SchedulerProviderType,
         contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Contact) -> Completable {
        return Completable.error(GeneralError.notImplemented)
    }

}
