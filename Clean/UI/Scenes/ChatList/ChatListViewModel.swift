//
//  ChatListViewModel.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ChatListViewModel {

    public typealias ChatViewModelFactory = ((Chat) -> ChatViewModel)

    let title: Variable<String> = Variable("Chats")
    let chats: Variable<[Chat]> = Variable([])

    var showChat: ((ChatViewModel) -> Void)?

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK: Dependencies

    private let getChatsUseCase: GetAllChatsUseCase
    private let getChatForContactUseCase: GetChatForContactUseCase
    private let chatViewModelFactory: ChatViewModelFactory

    public init(getChatsUseCase: GetAllChatsUseCase,
                getChatForContactUseCase: GetChatForContactUseCase,
                chatViewModelFactory: @escaping ChatViewModelFactory) {

        self.getChatsUseCase = getChatsUseCase
        self.getChatForContactUseCase = getChatForContactUseCase
        self.chatViewModelFactory = chatViewModelFactory

        getChatsUseCase
                .build()
                .bindTo(chats)
                .addDisposableTo(disposeBag)
    }

    public func cellViewModel(forIndexPath indexPath: IndexPath) -> ChatListCellViewModel {
        let chat = chats.value[indexPath.item]
        let vm = ChatListCellViewModel()
        vm.text = chat.participant.firstName
        return vm
    }

    public func startChat(forContact contact: Contact) {
        getChatForContactUseCase
                .build(contact: contact)
                .catchErrorJustReturn(Chat.createWith(participant: contact))
                .do(onNext: { [unowned self] chat in
                    let chatViewModel = self.chatViewModelFactory(chat)
                    self.showChat?(chatViewModel)
                })
                .subscribe()
                .addDisposableTo(disposeBag)
    }

}
