//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

import Common
import Domain

final class ContactListViewModel {

    let contacts: Variable<[Contact]> = Variable([])

    private(set) lazy var refreshAction: CocoaAction = {
        return CocoaAction { _ in
            self.getContactsUseCase
                .build()
                .do(onNext: {
                    self.contacts.value = $0
                })
                .mapToVoid()
        }
    }()

    fileprivate let disposeBag = DisposeBag()

    private let getContactsUseCase: ObserveContactsUseCase

    init(getContactsUseCase: ObserveContactsUseCase) {
        self.getContactsUseCase = getContactsUseCase

        getContactsUseCase.build()
                .bind(to: contacts)
                .addDisposableTo(disposeBag)
    }

}
