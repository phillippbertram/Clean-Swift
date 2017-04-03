//
//  MessageRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public protocol MessageRepositoryType {

    func getAll(`for` chat: Chat) -> Observable<[Message]>

    func create(message: String, sender: String, status: Message.Status) -> Observable<Message>

    func update(message: Message) -> Observable<Message>

}
