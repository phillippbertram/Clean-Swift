//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain

final class ContactListViewModel {

    let contacts: Variable<[Contact]> = Variable([])

    fileprivate let disposeBag = DisposeBag()

    init(getContactsUseCase: GetContactsUseCase) {
        getContactsUseCase.build()
            .bind(to: contacts)
            .addDisposableTo(disposeBag)
    }

}
