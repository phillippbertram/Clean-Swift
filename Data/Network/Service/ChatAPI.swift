//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public final class ChatAPI {

    public init() {

    }

    func getChats() -> Observable<[ChatDTO]> {
        return Observable.just([])
    }

}
