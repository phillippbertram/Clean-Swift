//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 06/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import RxSwift

/// External service that provides all contact related data

public protocol ContactServiceType {

    /// Gets all available chats.
    ///
    /// - Returns: Observable.
    func getAll() -> Observable<[Contact]>

    /// Gets a specific contact by given username.
    ///
    /// - Returns: Observable.
    func get(byUserName: String) -> Observable<Contact>

}
