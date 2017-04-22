//
// Created by Phillipp Bertram on 05/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public protocol SchedulerProviderType {

    /// Scheduler that runs on the main thread
    var mainScheduler: ImmediateSchedulerType { get }

    /// Scheduler that runs on a background thread
    var backgroundScheduler: ImmediateSchedulerType { get }

}
