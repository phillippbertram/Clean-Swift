//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import Domain
import Data

final class DomainAssembly: Assembly {

    // swiftlint:disable:next function_body_length
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

        container.register(ObserveAllChatsUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return ObserveAllChatsUseCase(schedulerProvider: schedulerProvider, chatRepository: chatRepository)
        }

        container.register(GetChatForContactUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return GetChatForContactUseCase(schedulerProvider: schedulerProvider, chatRepository: chatRepository)
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

        container.register(ObserveContactsUseCase.self) { resolver in
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            return ObserveContactsUseCase(schedulerProvider: schedulerProvider, contactRepository: contactRepository)
        }

        container.register(CreateContactUseCase.self) { resolver in
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            return CreateContactUseCase(schedulerProvider: schedulerProvider, contactRepository: contactRepository)
        }

        // MARK: Messages

        container.register(SendMessageUseCase.self) { resolver in
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let messageAPI = resolver.resolve(MessageServiceType.self)!
            let accountRepository = resolver.resolve(AccountRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return SendMessageUseCase(schedulerProvider: schedulerProvider,
                                      accountRepository: accountRepository,
                                      messageRepository: messageRepository,
                                      messageAPI: messageAPI)
        }

        container.register(ObserveMessagesUseCase.self) { resolver in
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return ObserveMessagesUseCase(schedulerProvider: schedulerProvider, messageRepository: messageRepository)
        }

        container.register(DeleteMessageUseCase.self) { resolver in
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return DeleteMessageUseCase(schedulerProvider: schedulerProvider,
                                        messageRepository: messageRepository)
        }

    }

}
