//
// Created by Phillipp Bertram on 05/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Common

public class UseCase<Input, Output> {

    let schedulerProvider: SchedulerProviderType

    init(schedulerProvider: SchedulerProviderType) {
        self.schedulerProvider = schedulerProvider
    }

    func buildObservable(params: Input) -> Observable<Output> {
        abstractMethod()
    }

    public final func build(_ params: Input) -> Observable<Output> {
        return buildObservable(params: params)
                .subscribeOn(schedulerProvider.backgroundScheduler)
                .observeOn(schedulerProvider.mainScheduler)
                .do(onNext: { output in
                    log.info("[\(type(of: self))] Next: \(output)")
                }, onError: { error in
                    log.error("[\(type(of: self))] Error: \(error)")
                }, onCompleted: {
                    log.info("[\(type(of: self))] Completed")
                }, onSubscribe: {
                    log.verbose("[\(type(of: self))] Subscribe")
                }, onSubscribed: {
                    log.verbose("[\(type(of: self))] Subscribed")
                }, onDispose: {
                    log.verbose("[\(type(of: self))] Dispose")
                })
    }

}
