//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class MessageDataSourceCache: DataSourceCache<Message>, MessageDataSource {

    public func getAll(for chat: Chat) -> Single<[Message]> {
        return get(byFilter: { $0.chatId == chat.id })
    }

}
