//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import RxSwift
import RxTest
import Domain


class TestSchedulerProvider: SchedulerProviderType {

    var mainScheduler: ImmediateSchedulerType {
        return mainTestScheduler
    }
    var backgroundScheduler: ImmediateSchedulerType {
        return backgroundTestScheduler
    }

    var var throttlingScheduler: SchedulerType {
        return throttlingTestScheduler
    }

    var mainTestScheduler = CurrentThreadScheduler.instance
    var backgroundTestScheduler = CurrentThreadScheduler.instance
    var throttlingTestScheduler = CurrentThreadScheduler.instance


}
