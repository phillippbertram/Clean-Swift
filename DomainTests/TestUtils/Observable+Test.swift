//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift
import RxTest

extension Observable {

    func test() -> TestableObserver<Element> {
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(Element.self)
        scheduler.start()
        _  = self.subscribe(observer)
        return observer
    }

}
