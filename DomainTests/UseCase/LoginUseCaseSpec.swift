//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Quick
import Nimble
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

                it("should") {
                    let params = LoginUseCaseParams(userName: "pbe", password: "secret")
                    let testObserver = sut.buildObservable(params: params).test()
                    expect(testObserver.events.count) == 1
                }

            }

        }
    }

}
