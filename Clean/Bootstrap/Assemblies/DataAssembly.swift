//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import RealmSwift
import Domain
import Data

final class DataAssembly: Assembly {

    func assemble(container: Container) {

        registerRepositories(container: container, scope: .container)
        registerDAOs(container: container, scope: .graph)
        registerAPIs(container: container, scope: .container)
        registerServices(container: container, scope: .container)

        // Utils

        container.register(SchedulerProviderType.self) { _ in
            return SchedulerProvider()
        }.inObjectScope(.container)

    }

    private func registerRepositories(container: Container, scope: ObjectScope) {
        container.register(ChatRepositoryType.self) { resolver in
            let chatDAO = resolver.resolve(ChatDAO.self)!
            return ChatRepository(chatDao: chatDAO)
        }.inObjectScope(scope)

        container.register(ContactRepositoryType.self) { resolver in
            let contactDao = resolver.resolve(ContactDAO.self)!
            return ContactRepository(contactDao: contactDao)
        }.inObjectScope(scope)

        container.register(AccountRepositoryType.self) { _ in
            return AccountRepository()
        }.inObjectScope(scope)

        container.register(MessageRepositoryType.self) { resolver in
            let messageDAO = resolver.resolve(MessageDAO.self)!
            return MessageRepository(messageDAO: messageDAO)
        }.inObjectScope(scope)

    }

    private func registerDAOs(container: Container, scope: ObjectScope) {
        container.register(Realm.Configuration.self) { _ in
            return Realm.Configuration(inMemoryIdentifier: "Clean-Swift")
        }.inObjectScope(.transient)

        container.register(MessageDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return MessageDAO(config: config)
        }.inObjectScope(scope)

        container.register(ChatDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return ChatDAO(config: config)
        }.inObjectScope(scope)

        container.register(ContactDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return ContactDAO(config: config)
        }.inObjectScope(scope)
    }

    private func registerAPIs(container: Container, scope: ObjectScope) {
        container.register(ChatAPI.self) { _ in
            return ChatAPI()
        }.inObjectScope(scope)

        container.register(ContactAPI.self) { _ in
            return ContactAPI()
        }.inObjectScope(scope)

        container.register(MessageAPI.self) { _ in
            return MessageAPI()
        }.inObjectScope(scope)
    }

    private func registerServices(container: Container, scope: ObjectScope) {
        container.register(MessageServiceType.self) { resolver in
            let messageAPI = resolver.resolve(MessageAPI.self)!
            return MessageService(messageAPI: messageAPI)
        }.inObjectScope(scope)
    }

}
