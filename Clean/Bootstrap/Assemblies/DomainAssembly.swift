//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import Domain
import Data

final class DomainAssembly: Assembly {

    func assemble(container: Container) {

        // Authentication

        container.register(LoginUseCase.self) { resolver in
            let currentUserRepository = resolver.resolve(AccountRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return LoginUseCase(schedulerProvider: schedulerProvider, currentUserRepository: currentUserRepository)
        }

        container.register(LogoutUseCase.self) { resolver in
            let currentUserRepository = resolver.resolve(AccountRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return LogoutUseCase(schedulerProvider: schedulerProvider, currentUserRepository: currentUserRepository)
        }

        // Chat

        container.register(GetAllChatsUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return GetAllChatsUseCase(schedulerProvider: schedulerProvider, chatRepository: chatRepository)
        }

        container.register(GetChatForContactUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            return GetChatForContactUseCase(chatRepository: chatRepository)
        }

        container.register(CreateChatForContactUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return CreateChatForContactUseCase(schedulerProvider: schedulerProvider, chatRepository: chatRepository)
        }

        container.register(DeleteChatUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return DeleteChatUseCase(schedulerProvider: schedulerProvider, chatRepository: chatRepository)
        }

        // MARK: Contacts

        container.register(GetContactsUseCase.self) { resolver in
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            return GetContactsUseCase(schedulerProvider: schedulerProvider, contactRepository: contactRepository)
        }

        // MARK: Messages

        container.register(SendMessageUseCase.self) { resolver in
            let createChatForContactUseCase = resolver.resolve(CreateChatForContactUseCase.self)!
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let messageService = resolver.resolve(MessageServiceType.self)!
            let currentUserRepository = resolver.resolve(AccountRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return SendMessageUseCase(schedulerProvider: schedulerProvider,
                                      createChatUseCase: createChatForContactUseCase,
                                      messageRepository: messageRepository,
                                      messageService: messageService,
                                      currentUserRepository: currentUserRepository)
        }

        container.register(ObserveMessagesUseCase.self) { resolver in
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return ObserveMessagesUseCase(schedulerProvider: schedulerProvider, messageRepository: messageRepository)
        }

    }

}
