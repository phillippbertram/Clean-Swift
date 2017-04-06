//
//  ChatListViewModel.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

public final class ChatListViewModel {

    let title: Variable<String> = Variable("Chats")
    let chats: Variable<[Chat]> = Variable([])

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    private let getChatsUseCase: GetChatsUseCase
    private let createChatUseCase: CreateChatUseCase

    public init(getChatsUseCase: GetChatsUseCase, createChatUseCase: CreateChatUseCase) {
        self.getChatsUseCase = getChatsUseCase
        self.createChatUseCase = createChatUseCase

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

}
