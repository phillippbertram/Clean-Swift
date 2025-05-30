//
//  ObserveContactsUseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ObserveContactsUseCase: UseCase<Void, [Contact]> {

    private let contactRepository: ContactRepositoryType

    public init(schedulerProvider: SchedulerProviderType, contactRepository: ContactRepositoryType) {
        self.contactRepository = contactRepository
        super.init(schedulerProvider: schedulerProvider)
    }

    public override func buildObservable(params: Void) -> Observable<[Contact]> {
        return contactRepository.getAll().map({ $0.sorted(by: <) }).asObservable()
    }

}
