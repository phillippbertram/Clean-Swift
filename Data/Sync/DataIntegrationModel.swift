//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

protocol DataIntegration {

    func importChats() -> Observable<[ChatEntity]>

}

final class DataIntegrationModel: DataIntegration {

    fileprivate let chatRepo: ChatRepositoryType
    fileprivate let contactRepo: ContactRepositoryType

    init(chatRepo: ChatRepositoryType,
         contactRepo: ContactRepositoryType) {
        self.chatRepo = chatRepo
        self.contactRepo = contactRepo
    }

    func importChats() -> Observable<[ChatEntity]> {
        return Observable.just([])
    }

}
