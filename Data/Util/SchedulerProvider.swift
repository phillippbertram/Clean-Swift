//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

final class SchedulerProvider: SchedulerProviderType {

    private(set) var mainScheduler: ImmediateSchedulerType = MainScheduler.instance
    private(set) var backgroundScheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)

}
