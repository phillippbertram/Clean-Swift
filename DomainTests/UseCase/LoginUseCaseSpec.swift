//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxTest

@testable import Domain

class LoginUseCaseSpec: QuickSpec {

    override func spec() {

        describe("LoginUseCase") {

            var sut: LoginUseCase!

            var schedulerProvider: TestSchedulerProvider!
            var currentUserRepository: MockCurrentUserRepository!

            beforeEach {

                schedulerProvider = TestSchedulerProvider()
                currentUserRepository = MockCurrentUserRepository()

                sut = LoginUseCase(schedulerProvider: schedulerProvider,
                                   currentUserRepository: currentUserRepository)
            }

            context("success") {

                it("should emit current user") {
                    // given
                    let params = LoginUseCaseParams(userName: "pbe", password: "secret")
                    currentUserRepository.loginObservableStub = { userName, password in
                        expect(userName) == params.userName
                        expect(password) == params.password
                        let user = CurrentUser(userName: "pbe", password: "secret", firstName: "Phillipp", lastName: "Bertram")
                        return Single.just(user)
                    }
                    
                    // when
                    let testObserver = sut.buildObservable(params: params).asObservable().test()
                    
                    // then
                    expect(testObserver.elementCount) == 1
                    expect(testObserver.hasCompleted) == true
                }

            }

        }
    }

}
