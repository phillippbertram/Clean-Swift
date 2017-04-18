//
//  MessageService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

/// External service that provides all message related data.
public protocol MessageServiceType {

    /// Sends given message to the service.
    ///
    /// - Parameter message: the message
    /// - Returns: Observable
    func send(message: Message, toContact: String) -> Single<Message>

}
