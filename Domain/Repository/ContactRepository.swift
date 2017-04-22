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

public struct CreateContactParam {

    public let userName: String
    public let firstName: String
    public let lastName: String

    public init(userName: String, firstName: String, lastName: String) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
    }
}

public protocol ContactRepositoryType {

    /// Gets all contacts.
    ///
    /// - Returns: Observable
    func getAll() -> Single<[Contact]>

    /// Gets a contact by it's username.
    ///
    /// - Parameter userName: username
    /// - Returns: Observable
    func getBy(userName: String) -> Single<Contact>

    /// Creates a contact with given information
    ///
    /// - Parameter contact: contact to create
    /// - Returns: Observable
    func create(params: CreateContactParam) -> Single<Contact>

}
