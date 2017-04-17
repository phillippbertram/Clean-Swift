//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class SchedulerProvider: SchedulerProviderType {

    public let mainScheduler: ImmediateSchedulerType = MainScheduler.instance
    public let backgroundScheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)

    public init() {

    }
}
