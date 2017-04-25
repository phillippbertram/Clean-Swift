//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

extension ObservableType {

    public func flatMapResult() -> Observable<Result<E>> {
        return map({ Result.success($0) })
                .catchError { error in
                    Observable.just(Result.failure(error))
                }
    }

}
