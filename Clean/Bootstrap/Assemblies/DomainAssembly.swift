//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import Domain
import Data

final class DomainAssembly: Assembly {

    func assemble(container: Container) {

        container.register(GetAllChatsUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let chatService = resolver.resolve(ChatServiceType.self)!
            return GetAllChatsUseCase(chatRepository: chatRepository, chatService: chatService)
        }

        container.register(GetChatForContactUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            return GetChatForContactUseCase(chatRepository: chatRepository)
        }

        container.register(CreateChatForContactUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            return CreateChatForContactUseCase(chatRepository: chatRepository)
        }

        container.register(LoginUseCase.self) { resolver in
            let currentUserRepository = resolver.resolve(CurrentUserRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return LoginUseCase(schedulerProvider: schedulerProvider, currentUserRepository: currentUserRepository)
        }

        container.register(GetContactsUseCase.self) { resolver in
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            return GetContactsUseCase(schedulerProvider: schedulerProvider, contactRepository: contactRepository)
        }

    }

}
