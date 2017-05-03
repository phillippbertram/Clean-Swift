//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class ChatDataSourceCache: DataSourceCache<Chat> {

}

// MARK: ChatDataSource

extension ChatDataSourceCache: ChatDataSource {

    func get(forUserName userName: String) -> Single<Chat> {
        return get(byFilter: {$0.participant.userName == userName}).map({$0.first!})
    }

}
