//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public enum ChatRepositoryError: Error {

    case chatNotFound(id: String)

}

public protocol ChatRepositoryType {

    func observeAllChats() -> Observable<[Chat]>

    func create(chat: Chat) -> Observable<Chat>

    func findChat(withId: String) -> Observable<Chat>

    func findAllChats() -> Observable<[Chat]>

}
