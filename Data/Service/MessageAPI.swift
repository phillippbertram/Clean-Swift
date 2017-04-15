//
//  ContactAPI.swift
//  Clean
//
//  Created by Phillipp Bertram on 10/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Foundation
import RxSwift

public final class MessageAPI {

    fileprivate var data: [String: MessageDTO] = [:]

    fileprivate func addMessage(_ message: MessageDTO) {
        data[message.id] = message
    }

    public init() {
        prepareData()
    }

}

// MARK: - Public API

extension MessageAPI {

    public func send(message request: MessageRequestDTO, receiver: String) -> Observable<MessageDTO> {
        return Observable.empty()
    }

    public func getAllForChat(withId chatId: String) -> Observable<[MessageDTO]> {
        return Observable.empty()
    }

}

// MARK: - Dummy Data

fileprivate extension MessageAPI {

    func prepareData() {

    }

}
