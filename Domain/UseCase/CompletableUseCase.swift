//
// Created by Phillipp Bertram on 18.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public class CompletableUseCase<Input> {

    let schedulerProvider: SchedulerProviderType

    init(schedulerProvider: SchedulerProviderType) {
        self.schedulerProvider = schedulerProvider
    }

    func buildObservable(params: Input) -> Completable {
        fatalError("Has to be implemented by subclass")
    }

    public final func build(_ params: Input) -> Completable {
        return buildObservable(params: params)
                .subscribeOn(schedulerProvider.backgroundScheduler)
                .observeOn(schedulerProvider.mainScheduler)
                .do(onError: { error in
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
