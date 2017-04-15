//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import RxSwift

enum APIError: Error {

    case general

}

public final class ContactAPI {

    fileprivate var data: [String: ContactDTO] = [:]

    fileprivate func addContact(_ contact: ContactDTO) {
        data[contact.userName] = contact
    }

    public init() {
        prepareData()
    }

}

// MARK: - Public API

extension ContactAPI {

    public func getAll() -> Observable<[ContactDTO]> {
        return Observable.just(Array(data.values))
                .delay(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
    }

    public func get(byId id: String) -> Observable<ContactDTO> {
        return Observable.deferred {
            guard let contact = self.data[id] else {
                return Observable.error(APIError.general)
            }
            return Observable.just(contact)
                    .delay(2, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
        }
    }

}

// MARK: - Dummy Data

fileprivate extension ContactAPI {

    func prepareData() {
        let pbe = ContactDTO(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        let alb = ContactDTO(userName: "alb", firstName: "Alexander", lastName: "Brechmann")
        let waw = ContactDTO(userName: "waw", firstName: "Waldemar", lastName: "Weißhaar")
        let nih = ContactDTO(userName: "nih", firstName: "Nils", lastName: "Hohmann")
        let cwo = ContactDTO(userName: "cwo", firstName: "Christof", lastName: "Wolke")
        let mdr = ContactDTO(userName: "mdr", firstName: "Matthias", lastName: "Dierker")
        addContact(pbe)
        addContact(alb)
        addContact(waw)
        addContact(nih)
        addContact(cwo)
        addContact(mdr)
    }

}
