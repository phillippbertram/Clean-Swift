//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
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

        container.register(ContactRepositoryType.self) { resolver in
            let contactService = resolver.resolve(ContactServiceType.self)!
            return ContactRepository(contactService: contactService)
        }.inObjectScope(.container)

        container.register(CurrentUserRepositoryType.self) { _ in
            return CurrentUserRepository()
        }.inObjectScope(.container)

        container.register(MessageRepositoryType.self) { resolver in
            let messageService = resolver.resolve(MessageServiceType.self)!
            return MessageRepository(messageService: messageService)
        }.inObjectScope(.container)

        // Services

        container.register(ChatServiceType.self) { resolver in
            let chatAPI = resolver.resolve(ChatAPI.self)!
            let contactAPI = resolver.resolve(ContactAPI.self)!
            return ChatService(chatAPI: chatAPI, contactAPI: contactAPI)
        }.inObjectScope(.container)

        container.register(ContactServiceType.self) { resolver in
            let contactAPI = resolver.resolve(ContactAPI.self)!
            return ContactService(contactAPI: contactAPI)
        }.inObjectScope(.container)

        container.register(MessageServiceType.self) { resolver in
            let contactService = resolver.resolve(ContactServiceType.self)!
            let messageAPI = resolver.resolve(MessageAPI.self)!
            return MessageService(messageAPI: messageAPI, contactService: contactService)
        }

        // APIs

        container.register(ChatAPI.self) { _ in
            return ChatAPI()
        }.inObjectScope(.container)

        container.register(ContactAPI.self) { _ in
            return ContactAPI()
        }.inObjectScope(.container)

        container.register(MessageAPI.self) { _ in
            return MessageAPI()
            }.inObjectScope(.container)

    }

}
