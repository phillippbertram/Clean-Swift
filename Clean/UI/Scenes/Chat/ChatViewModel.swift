//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ChatViewModel {

    let title: Variable<String>

    fileprivate let disposeBag = DisposeBag()

    fileprivate let sendMessageUseCase: SendMessageUseCase
    fileprivate let chat: Variable<Chat>

    public init(chat: Chat, sendMessageUseCase: SendMessageUseCase) {
        self.chat = Variable(chat)
        self.title = Variable(chat.participant.displayName)
        self.sendMessageUseCase = sendMessageUseCase
    }

    public func sendTextMessage(_ text: String) {
        sendMessageUseCase
            .build(chat: chat.value, messageText: text)
            .subscribe()
            .addDisposableTo(disposeBag)
    }

}
