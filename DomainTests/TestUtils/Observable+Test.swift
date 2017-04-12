//
// Created by Phillipp Bertram on 08/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
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

extension TestableObserver {

    var elements: [Element] {
        return events.map({ $0.value.element }).flatMap({ $0 })
    }

    var elementCount: Int {
        return elements.count
    }

    var hasErrors: Bool {
        return events.filter { record in
            record.value.error != nil
        }.count != 0
    }

    var hasCompleted: Bool {
        guard let lastEvent = events.last else {
            return false
        }
        switch lastEvent.value {
            case .completed:
                return true
            default:
                return false
        }
    }

}
