//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ChatViewModel {

    let title: Variable<String>

    private let chat: Variable<Chat>

    public init(chat: Chat) {
        self.chat = Variable(chat)
        self.title = Variable(chat.participant.displayName)
    }

}
