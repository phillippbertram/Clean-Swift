//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public enum ChatHolder {

    case temporary(Contact)
    case existing(Chat)

    var chat: Chat? {
        if case let .existing(chat) = self {
            return chat
        }
        return nil
    }

    var chatAvailable: Bool {
        return chat != nil
    }

}

public final class ChatViewModel {

    public typealias ViewModelFactory = ((ChatHolder) -> ChatViewModel)

    public let title: Variable<String> = Variable("")
    public let messages: Variable<[Message]> = Variable([])

    fileprivate let disposeBag = DisposeBag()

    // MARK: Dependencies

    fileprivate let sendMessageUseCase: SendMessageUseCase
    fileprivate let deleteMessageUseCase: DeleteMessageUseCase
    fileprivate let createChatUseCase: CreateChatForContactUseCase
    fileprivate let observeMessages: ObserveMessagesUseCase
    fileprivate let chatHolder: Variable<ChatHolder>

    public init(chatHolder: ChatHolder,
                createChatUseCase: CreateChatForContactUseCase,
                sendMessageUseCase: SendMessageUseCase,
                observeMessages: ObserveMessagesUseCase,
                deleteMessageUseCase: DeleteMessageUseCase) {
        self.chatHolder = Variable(chatHolder)
        self.sendMessageUseCase = sendMessageUseCase
        self.deleteMessageUseCase = deleteMessageUseCase
        self.createChatUseCase = createChatUseCase
        self.observeMessages = observeMessages

        setupBinding()
    }

    private func setupBinding() {
        let chatObserver = self.chatHolder
                .asObservable()

        // observe title
        chatObserver
                .map { holder in
                    switch holder {
                        case .temporary(let contact):
                            return contact.displayName
                        case .existing(let chat):
                            return chat.displayName
                    }
                }
                .bind(to: self.title)
                .addDisposableTo(disposeBag)

        // observe messages
        chatObserver
                .filter({ $0.chat != nil })
                .map({ $0.chat! })
                .flatMapLatest { [unowned self] in
                    self.observeMessages.build($0)
                }
                .bind(to: messages)
                .addDisposableTo(disposeBag)
    }

}

// MARK: - Public API

extension ChatViewModel {

    public func sendTextMessage(_ text: String) {
        Single.deferred { [unowned self] () -> Single<Chat> in
                    switch self.chatHolder.value {
                        case .existing(let chat):
                            return Single.just(chat)
                        case .temporary(let contact):
                            return self.createChatUseCase.build(contact)
                                    .do(onNext: { [unowned self] chat in
                                        if !self.chatHolder.value.chatAvailable {
                                            self.chatHolder.value = .existing(chat)
                                        }
                                    })
                    }
                }
                .flatMap { [unowned self] chat in
                    return self.sendMessageUseCase
                            .build(SendMessageUseCaseParams.from(chat: chat, messageText: text))
                }
                .subscribe()
                .addDisposableTo(disposeBag)
    }

    public func delete(message: Message) {
        deleteMessageUseCase
                .build(message)
                .subscribe()
                .addDisposableTo(disposeBag)
    }

}
