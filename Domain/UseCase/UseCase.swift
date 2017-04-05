//
// Created by Phillipp Bertram on 05/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public class UseCase<Input, Output> {

    let schedulerProvider: SchedulerProviderType

    init(schedulerProvider: SchedulerProviderType) {
        self.schedulerProvider = schedulerProvider
    }

    func buildObservable(params: Input) -> Observable<Output> {
        fatalError("Has to be implemented by subclass")
    }

    public func build(_ params: Input) -> Observable<Output> {
        return buildObservable(params: params)
                .subscribeOn(schedulerProvider.backgroundScheduler)
                .observeOn(schedulerProvider.mainScheduler)
    }

}
