//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import RealmSwift
import Domain

final class ViewAssembly: Assembly {

    // swiftlint:disable:next function_body_length
    func assemble(container: Container) {

        // Utils

        container.register(Seeder.self) { resolver in
            let createContactUseCase = resolver.resolve(CreateContactUseCase.self)!
            return Seeder(createContactUseCase: createContactUseCase)
        }

        container.register(DataBaseLogger.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return DataBaseLogger(realmConfig: config)
        }

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
            vc.dataBaseLogger = resolver.resolve(DataBaseLogger.self)
        }

        container.register(ChatListViewModel.self) { resolver in
            let getChatsUseCase = resolver.resolve(ObserveAllChatsUseCase.self)!
            let getChatForContactUseCase = resolver.resolve(GetChatForContactUseCase.self)!
            let deleteChatUseCase = resolver.resolve(DeleteChatUseCase.self)!

            let chatViewModelFactory: ChatViewModel.ViewModelFactory = { (chatHolder: ChatHolder) in
                return resolver.resolve(ChatViewModel.self, argument: chatHolder)!
            }

            return ChatListViewModel(getChatsUseCase: getChatsUseCase,
                                     getChatForContactUseCase: getChatForContactUseCase,
                                     deleteChatUseCase: deleteChatUseCase,
                                     chatViewModelFactory: chatViewModelFactory)
        }

        // Chat

        container.storyboardInitCompleted(ChatViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ChatViewModel.self)
        }

        container.register(ChatViewModel.self) { (resolver, chat: ChatHolder) in
            let sendMessageUseCase = resolver.resolve(SendMessageUseCase.self)!
            let observeMessages = resolver.resolve(ObserveMessagesUseCase.self)!
            let deleteMessageUseCase = resolver.resolve(DeleteMessageUseCase.self)!
            let createChatUseCase = resolver.resolve(CreateChatForContactUseCase.self)!
            return ChatViewModel(chatHolder: chat,
                                 createChatUseCase: createChatUseCase,
                                 sendMessageUseCase: sendMessageUseCase,
                                 observeMessages: observeMessages,
                                 deleteMessageUseCase: deleteMessageUseCase)
        }

        // Contact

        container.storyboardInitCompleted(ContactListViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ContactListViewModel.self)
        }

        container.register(ContactListViewModel.self) { resolver in
            let getContactsUseCase = resolver.resolve(ObserveContactsUseCase.self)!
            return ContactListViewModel(getContactsUseCase: getContactsUseCase)
        }

        // Contact Selection

        container.storyboardInitCompleted(ContactSelectionViewController.self) { resolver, vc in
            vc.viewModel = resolver.resolve(ContactSelectionViewModel.self)
        }

        container.register(ContactSelectionViewModel.self) { resolver in
            let getContacts = resolver.resolve(ObserveContactsUseCase.self)!
            return ContactSelectionViewModel(getContactsUseCase: getContacts)
        }

    }

}
