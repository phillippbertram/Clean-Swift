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

    func send(message request: MessageRequestDTO, receiver: String) -> Single<MessageDTO>

    func messagesForChat(withId: String) -> Single<[MessageDTO]>

}
