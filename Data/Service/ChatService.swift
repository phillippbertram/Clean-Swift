//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 31/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

final class ChatService {

    func getChats() -> Observable<[ChatDTO]> {
        return Observable.just([ChatDTO(), ChatDTO()])
    }

}
