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

    let title: Variable<String> = Variable("Chats")
    let chats: Variable<[Chat]> = Variable([])

    var showChat: ((ChatViewModel) -> Void)?

    func reloadChats() {
        getChatsUseCase
                .build()
                .bind(to: chats)
                .addDisposableTo(disposeBag)
    }

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK: Dependencies

    private let getChatsUseCase: ObserveAllChatsUseCase
    private let getChatForContactUseCase: GetChatForContactUseCase
    private let deleteChatUseCase: DeleteChatUseCase
    private let chatViewModelFactory: ChatViewModel.ViewModelFactory

    public init(getChatsUseCase: ObserveAllChatsUseCase,
                getChatForContactUseCase: GetChatForContactUseCase,
                deleteChatUseCase: DeleteChatUseCase,
                chatViewModelFactory: @escaping ChatViewModel.ViewModelFactory) {

        self.getChatsUseCase = getChatsUseCase
        self.getChatForContactUseCase = getChatForContactUseCase
        self.deleteChatUseCase = deleteChatUseCase
        self.chatViewModelFactory = chatViewModelFactory

        reloadChats()
    }

    public func cellViewModel(forIndexPath indexPath: IndexPath) -> ChatListCellViewModel {
        let chat = chats.value[indexPath.item]
        let vm = ChatListCellViewModel()
        vm.text = chat.participant.firstName
        return vm
    }

    public func delete(chat: Chat) {
        deleteChatUseCase
                .build(chat)
                .subscribe()
                .addDisposableTo(disposeBag)
    }

    public func startExistingChat(_ chat: Chat) {
        let chatViewModel = self.chatViewModelFactory(.existing(chat))
        self.showChat?(chatViewModel)
    }

    public func startChat(forContact contact: Contact) {
        getChatForContactUseCase
                .build(contact: contact)
                .map({ChatHolder.existing($0)})
                .catchErrorJustReturn(ChatHolder.temporary(contact))
                .do(onNext: { [unowned self] chatHolder in
                    let chatViewModel = self.chatViewModelFactory(chatHolder)
                    self.showChat?(chatViewModel)
                })
                .subscribe()
                .addDisposableTo(disposeBag)
    }

}
