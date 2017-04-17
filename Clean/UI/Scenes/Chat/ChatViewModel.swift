//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ChatViewModel {

    let title: Variable<String>
    let messages: Variable<[Message]> = Variable([])

    fileprivate let disposeBag = DisposeBag()

    fileprivate let sendMessageUseCase: SendMessageUseCase
    fileprivate let chat: Variable<Chat>

    public init(chat: Chat,
                sendMessageUseCase: SendMessageUseCase,
                observeMessages: ObserveMessagesUseCase) {
        self.chat = Variable(chat)
        self.title = Variable(chat.participant.displayName)
        self.sendMessageUseCase = sendMessageUseCase

        observeMessages
                .build(chat)
                .bind(to: messages)
                .addDisposableTo(disposeBag)
    }

    public func sendTextMessage(_ text: String) {
        sendMessageUseCase
            .build(SendMessageUseCaseParams.from(chat: chat.value, messageText: text))
            .subscribe()
            .addDisposableTo(disposeBag)
    }

}
