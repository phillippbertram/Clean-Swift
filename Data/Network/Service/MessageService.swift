//
//  MessageService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

final class MessageService: MessageServiceType {

    func send(message: Message) -> Observable<Message> {
        return Observable.empty()
    }
}
