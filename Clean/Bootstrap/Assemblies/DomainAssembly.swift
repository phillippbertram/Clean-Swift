//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import Domain
import Data

final class DomainAssembly: Assembly {

    func assemble(container: Container) {

        container.register(GetChatsUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            let chatService = resolver.resolve(ChatServiceType.self)!
            return GetChatsUseCase(chatRepository: chatRepository, chatService: chatService)
        }

        container.register(LoginUseCase.self) { resolver in
            let currentUserRepository = resolver.resolve(CurrentUserRepositoryType.self)!
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            return LoginUseCase(schedulerProvider: schedulerProvider, currentUserRepository: currentUserRepository)
        }

        container.register(CreateChatUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            return CreateChatUseCase(chatRepository: chatRepository)
        }

        container.register(GetContactsUseCase.self) { resolver in
            let schedulerProvider = resolver.resolve(SchedulerProviderType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            return GetContactsUseCase(schedulerProvider: schedulerProvider, contactRepository: contactRepository)
        }

    }

}
