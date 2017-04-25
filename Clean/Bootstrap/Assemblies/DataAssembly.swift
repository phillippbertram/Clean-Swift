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
        registerDataSources(container: container, scope: .graph)
        registerDAOs(container: container, scope: .graph)
        registerAPIs(container: container, scope: .container)
        registerImporter(container: container, scope: .graph)

        // Utils

        container.register(SchedulerProviderType.self) { _ in
            return SchedulerProvider()
        }.inObjectScope(.container)

    }

}

// MARK: Registrations

fileprivate extension DataAssembly {

    fileprivate func registerRepositories(container: Container, scope: ObjectScope) {
        container.register(ChatRepositoryType.self) { resolver in
            let localDataSource = resolver.resolve(ChatDataSourceLocal.self)!
            let networkDataSource = resolver.resolve(ChatDataSourceNetwork.self)!
            return ChatRepository(localDataSource: localDataSource, networkDataSource: networkDataSource)
        }.inObjectScope(scope)

        container.register(ContactRepositoryType.self) { resolver in
            let dbDataSource = resolver.resolve(ContactDataSourceLocal.self)!
            let networkDataSource = resolver.resolve(ContactDataSourceNetwork.self)!
            return ContactRepository(localDataSource: dbDataSource, networkDataSource: networkDataSource)
        }.inObjectScope(scope)

        container.register(AccountRepositoryType.self) { _ in
            return AccountRepository()
        }.inObjectScope(scope)

        container.register(MessageRepositoryType.self) { resolver in
            let localDataSource = resolver.resolve(MessageDataSourceLocal.self)!
            let messageApi = resolver.resolve(MessageApiType.self)!
            return MessageRepository(localDataSource: localDataSource,
                                     messageApi: messageApi)
        }.inObjectScope(scope)

    }

    fileprivate func registerDataSources(container: Container, scope: ObjectScope) {
        container.register(ContactDataSourceNetwork.self) { resolver in
            let contactApi = resolver.resolve(ContactApiType.self)!
            return ContactDataSourceNetwork(contactApi: contactApi)
        }.inObjectScope(scope)

        container.register(ContactDataSourceLocal.self) { resolver in
            let contactDao = resolver.resolve(ContactDAO.self)!
            return ContactDataSourceLocal(contactDAO: contactDao)
        }.inObjectScope(scope)

        container.register(ChatDataSourceNetwork.self) { resolver in
            let chatApi = resolver.resolve(ChatApiType.self)!
            return ChatDataSourceNetwork(chatApi: chatApi)
        }.inObjectScope(scope)

        container.register(ChatDataSourceLocal.self) { resolver in
            let chatDao = resolver.resolve(ChatDAO.self)!
            return ChatDataSourceLocal(chatDao: chatDao)
        }.inObjectScope(scope)
    }

    fileprivate func registerDAOs(container: Container, scope: ObjectScope) {
        container.register(Realm.Configuration.self) { _ in
            return Realm.Configuration(inMemoryIdentifier: "CleanSwift", deleteRealmIfMigrationNeeded: true)
        }.inObjectScope(.transient)

        container.register(MessageDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return MessageDAO(config: config)
        }.inObjectScope(scope)

        container.register(ChatDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            let messageDAO = resolver.resolve(MessageDAO.self)!
            return ChatDAO(config: config, messageDAO: messageDAO)
        }.inObjectScope(scope)

        container.register(ContactDAO.self) { resolver in
            let config = resolver.resolve(Realm.Configuration.self)!
            return ContactDAO(config: config)
        }.inObjectScope(scope)
    }

    fileprivate func registerAPIs(container: Container, scope: ObjectScope) {
        container.register(MessageApiType.self) { resolver in
            let accountRepository = resolver.resolve(AccountRepositoryType.self)!
            return MessageApi(accountRepository: accountRepository)
        }.inObjectScope(scope)

        container.register(ContactApiType.self) { _ in
            return ContactApi()
        }.inObjectScope(scope)

        container.register(ChatApiType.self) { _ in
            return ChatApi()
        }.inObjectScope(scope)
    }

    fileprivate func registerImporter(container: Container, scope: ObjectScope) {
        container.register(ApiMessagesImporter.self) { resolver in
            let messageRepository = resolver.resolve(MessageRepositoryType.self)!
            let contactRepository = resolver.resolve(ContactRepositoryType.self)!
            let accountRepository = resolver.resolve(AccountRepositoryType.self)!
            return ApiMessagesImporter(messageRepository: messageRepository,
                                       contactRepository: contactRepository,
                                       accountRepository: accountRepository)
        }.inObjectScope(scope)

    }

}
