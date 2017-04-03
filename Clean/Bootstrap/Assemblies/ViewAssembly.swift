//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import Domain

final class ViewAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(ChatListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ChatListViewModel.self)
        }

        container.register(ChatListViewModel.self) { resolver in
            let getChatsUseCase = resolver.resolve(GetChatsUseCase.self)!
            return ChatListViewModel(getChatsUseCase: getChatsUseCase)
        }

    }

}
