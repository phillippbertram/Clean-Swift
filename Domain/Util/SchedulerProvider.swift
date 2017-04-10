//
// Created by Phillipp Bertram on 05/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public protocol SchedulerProviderType {

    var mainScheduler: ImmediateSchedulerType { get }
    var backgroundScheduler: ImmediateSchedulerType { get }

}
