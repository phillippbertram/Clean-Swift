//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

final class LogoutUseCase {

    fileprivate let currentUserRepository: CurrentUserRepositoryType

    init(currentUserRepository: CurrentUserRepositoryType) {
        self.currentUserRepository = currentUserRepository
    }

    func build() -> Observable<Void> {
        return self.currentUserRepository.logout()
    }

}
