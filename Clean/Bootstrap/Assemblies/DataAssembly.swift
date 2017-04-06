//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import Domain
import Data

final class DataAssembly: Assembly {

    func assemble(container: Container) {

        // Utils

        container.register(SchedulerProviderType.self) { _ in
            return SchedulerProvider()
        }

        // Repositories

        container.register(ChatRepositoryType.self) { _ in
            return ChatRepository()
        }.inObjectScope(.container)

        container.register(ContactRepositoryType.self) { _ in
            return ContactRepository()
        }.inObjectScope(.container)

        container.register(CurrentUserRepositoryType.self) { _ in
            return CurrentUserRepository()
        }.inObjectScope(.container)

        // Services

        container.register(ChatServiceType.self) { resolver in
            let chatAPI = resolver.resolve(ChatAPI.self)!
            let contactAPI = resolver.resolve(ContactAPI.self)!
            return ChatService(chatAPI: chatAPI, contactAPI: contactAPI)
        }

        // APIs

        container.register(ChatAPI.self) { _ in
            return ChatAPI()
        }

        container.register(ContactAPI.self) { _ in
            return ContactAPI()
        }

    }

}
