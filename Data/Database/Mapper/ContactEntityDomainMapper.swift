//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import Domain

final class ContactEntityDomainMapper {

    func map(_ entity: ContactEntity) -> Contact {
        return Contact(userName: entity.userName, firstName: entity.firstName, lastName: entity.lastName)
    }

    func mapAll(_ entities: [ContactEntity]) -> [Contact] {
        return entities.map(map)
    }

}
