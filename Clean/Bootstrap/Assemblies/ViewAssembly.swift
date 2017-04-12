//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
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

        // ChatList

        container.storyboardInitCompleted(ChatListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ChatListViewModel.self)
        }

        container.register(ChatListViewModel.self) { resolver in
            let getChatsUseCase = resolver.resolve(GetAllChatsUseCase.self)!
            let getChatForContactUseCase = resolver.resolve(GetChatForContactUseCase.self)!

            let chatViewModelFactory: ChatListViewModel.ChatViewModelFactory = { conversation in
                return resolver.resolve(ChatViewModel.self, argument: conversation)!
            }

            return ChatListViewModel(getChatsUseCase: getChatsUseCase,
                                     getChatForContactUseCase: getChatForContactUseCase,
                                     chatViewModelFactory: chatViewModelFactory)
        }

        // Chat

        container.storyboardInitCompleted(ChatViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ChatViewModel.self)
        }

        container.register(ChatViewModel.self) { _, chat in
            ChatViewModel(chat: chat)
        }

        // Contact

        container.storyboardInitCompleted(ContactListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ContactListViewModel.self)
        }

        container.register(ContactListViewModel.self) { resolver in
            let getContactsUseCase = resolver.resolve(GetContactsUseCase.self)!
            return ContactListViewModel(getContactsUseCase: getContactsUseCase)
        }

        // Contact Selection

        container.storyboardInitCompleted(ContactSelectionViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ContactSelectionViewModel.self)
        }

        container.register(ContactSelectionViewModel.self) { resolver in
            let getContacts = resolver.resolve(GetContactsUseCase.self)!
            return ContactSelectionViewModel(getContactsUseCase: getContacts)
        }

    }

}
