//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain

final class ApiContactDomainMapper {

    func mapAll(apiContacts: [ApiContact]) -> [Contact] {
        return apiContacts.map(map)
    }

    func map(apiContact: ApiContact) -> Contact {
        return Contact(userName: apiContact.userName,
                       firstName: apiContact.firstName,
                       lastName: apiContact.lastName)
    }

}
