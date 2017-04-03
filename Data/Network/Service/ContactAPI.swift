//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation
import RxSwift

final class ContactAPI {

    func getContact(byId: String) -> Observable<ContactDTO> {
        let contact = ContactDTO(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        return Observable.just(contact)
    }
}
