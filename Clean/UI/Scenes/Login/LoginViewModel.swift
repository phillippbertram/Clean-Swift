//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa
import Action

final class LoginViewModel {

    let userName: Variable<String?> = Variable(nil)
    let password: Variable<String?> = Variable(nil)

    private(set) lazy var loginAction: CocoaAction = {
        return CocoaAction { _ in
            let userName = self.userName.value ?? ""
            let password = self.password.value ?? ""
            return self.loginUseCase
                    .build(LoginUseCaseParams(userName: userName, password: password))
                    .map({ _ in () })
                    .asObservable()
        }
    }()

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

}
