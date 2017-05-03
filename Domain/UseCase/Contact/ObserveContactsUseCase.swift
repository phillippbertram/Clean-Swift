//
//  ObserveContactsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import RxSwiftExt

public final class ObserveContactsUseCase: UseCase<Void, [Contact]> {

    private let contactRepository: ContactRepositoryType

    public init(schedulerProvider: SchedulerProviderType, contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    override func buildObservable(params: Void) -> Observable<[Contact]> {
        return contactRepository
                .getAll()
                .asObservable()
                .throttle(0.25, scheduler: schedulerProvider.throttlingScheduler)
                .map({ $0.sorted(by: <) })
                .catchErrorJustComplete()
    }

}
