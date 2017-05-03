//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Common
import RxSwift

protocol ContactService {

    func block(userName: String) -> Completable

}

final class BlockContactUseCase: CompletableUseCase<Contact> {

    fileprivate let contactRepository: ContactRepositoryType
    fileprivate let contactService: ContactService

    init(schedulerProvider: SchedulerProviderType,
         contactRepository: ContactRepositoryType,
         contactService: ContactService) {
        self.contactRepository = contactRepository
        self.contactService = contactService
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Contact) -> Completable {
        notImplemented()
    }

}
