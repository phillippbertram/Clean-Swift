//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import Domain
import Data

final class DataAssembly: Assembly {

    func assemble(container: Container) {

        // Repositories

        container.register(ChatRepositoryType.self) { _ in
            return ChatRepository()
        }

        container.register(CurrentUserRepositoryType.self) { resolver in
            return CurrentUserRepository()
        }

        // Services

        container.register(ChatServiceType.self) { resolver in
            let chatAPI = resolver.resolve(ChatAPI.self)!
            let contactAPI = resolver.resolve(ContactAPI.self)!
            return ChatService(chatAPI: chatAPI, contactAPI: contactAPI)
        }

        // APIs

        container.register(ChatAPI.self) { resolver in
            return ChatAPI()
        }

        container.register(ContactAPI.self) { resolver in
            return ContactAPI()
        }

    }

}
