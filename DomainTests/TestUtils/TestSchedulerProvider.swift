//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
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

//    var mainTestScheduler = TestScheduler(initialClock: 0)
//    var backgroundTestScheduler = TestScheduler(initialClock: 0)
    
    var mainTestScheduler = CurrentThreadScheduler.instance
    var backgroundTestScheduler = CurrentThreadScheduler.instance
    
}
