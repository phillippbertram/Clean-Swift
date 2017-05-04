//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public protocol MessageDataSource {
    
    /// Gets all messages for given chat.
    ///
    /// - Parameter chat: the chat.
    /// - Returns: Single
    func getAll(`for` chat: Chat) -> Single<[Message]>

}
