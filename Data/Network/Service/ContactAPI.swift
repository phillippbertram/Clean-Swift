//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import RxSwift

public final class ContactAPI {

    public init() {

    }

    func getContact(byId: String) -> Observable<ContactDTO> {
        let contact = ContactDTO(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        return Observable.just(contact)
    }
}
