//
// Created by Phillipp Bertram on 10/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ContactSelectionViewModel {

    public let contacts: Variable<[Contact]> = Variable([])

    private let disposeBag = DisposeBag()

    init(getContactsUseCase: GetContactsUseCase) {
        getContactsUseCase.build().bindTo(contacts).addDisposableTo(disposeBag)
    }

}
