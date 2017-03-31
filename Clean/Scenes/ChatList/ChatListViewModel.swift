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

final class ChatListViewModel {

    let title: Variable<String> = Variable("Chats")
    let chats: Variable<[Chat]> = Variable([])

    private let disposeBag = DisposeBag()

    private let getChatsUseCase: GetChatsUseCase

    init(getChatsUseCase: GetChatsUseCase) {
        self.getChatsUseCase = getChatsUseCase

        getChatsUseCase
                .build()
                .bindTo(chats)
                .addDisposableTo(disposeBag)
    }

}
