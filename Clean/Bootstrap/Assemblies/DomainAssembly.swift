//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import Swinject
import Domain
import Data

final class DomainAssembly: Assembly {

    func assemble(container: Container) {

        // Use Cases

        container.register(GetChatsUseCase.self) { resolver in
            let chatRepository = resolver.resolve(ChatRepositoryType.self)!
            return GetChatsUseCase(chatRepository: chatRepository)
        }

        // Repositories

        container.register(ChatRepositoryType.self) { _ in
            return ChatRepository()
        }
    }

}
