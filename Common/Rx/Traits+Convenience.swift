//
// Created by Phillipp Bertram on 19.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public extension PrimitiveSequence {

    public func asCompletable() -> Completable {
        return asObservable()
                .toArray()
                .flatMap { _ in
                    Observable<Never>.empty()
                }.asCompletable()
    }

}

public extension Single {

    public func catchErrorJustReturn(_ element: Element) -> Single<Element> {
        return asObservable().catchErrorJustReturn(element).asSingle()
    }

}
