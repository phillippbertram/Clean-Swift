//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import Domain

final class ViewAssembly: Assembly {

    func assemble(container: Container) {

        // Login

        container.storyboardInitCompleted(LoginViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(LoginViewModel.self)
        }

        container.register(LoginViewModel.self) { resolver in
            let loginUseCase = resolver.resolve(LoginUseCase.self)!
            return LoginViewModel(loginUseCase: loginUseCase)
        }

        // Chat

        container.storyboardInitCompleted(ChatListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ChatListViewModel.self)
        }

        container.register(ChatListViewModel.self) { resolver in
            let getChatsUseCase = resolver.resolve(GetChatsUseCase.self)!
            let createChatUseCase = resolver.resolve(CreateChatUseCase.self)!
            return ChatListViewModel(getChatsUseCase: getChatsUseCase, createChatUseCase: createChatUseCase)
        }

        // Contact

        container.storyboardInitCompleted(ContactListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ContactListViewModel.self)
        }

        container.register(ContactListViewModel.self) { resolver in
            let getContactsUseCase = resolver.resolve(GetContactsUseCase.self)!
            return ContactListViewModel(getContactsUseCase: getContactsUseCase)
        }

    }

}
