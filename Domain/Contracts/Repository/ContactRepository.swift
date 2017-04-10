//
//  ContactRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public enum ContactRepositoryError: Error {
    case contactNotFound
}

public protocol ContactRepositoryType {

    /// Gets all contacts.
    ///
    /// - Returns: Observble
    func getAll() -> Observable<[Contact]>

    /// Gets a contact by it's username.
    ///
    /// - Parameter userName: username
    /// - Returns: Observable
    func getBy(userName: String) -> Observable<Contact>

}
