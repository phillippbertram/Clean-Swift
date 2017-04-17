//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ChatAPI {

    var data: [ChatDTO] = []

    // swiftlint:disable line_length
    public init() {
        let chat1 = ChatDTO(id: "123", initiator: "pbe", receiver: "alb", messages: [], createdAt: Date(), modifiedAt: Date())
        let chat2 = ChatDTO(id: "234", initiator: "cwo", receiver: "pbe", messages: [], createdAt: Date(), modifiedAt: Date())
        let chat3 = ChatDTO(id: "345", initiator: "pbe", receiver: "mdr", messages: [], createdAt: Date(), modifiedAt: Date())
        data = [chat1, chat2, chat3]
    }
    // swiftlint:enable line_length

    func getChats() -> Observable<[ChatDTO]> {
        return Observable.just(data)
    }

}
