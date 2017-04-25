//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift

public final class MessageDAO: RealmBaseDAO<MessageEntity> {

    func observe(forChat chatId: String) -> Observable<[MessageEntity]> {
        return observe(byFilter: NSPredicate(format: "chat.id == '\(chatId)'"))
    }

    func findAll(forChat chatId: String) -> [MessageEntity] {
        return find(withFilter: { $0.chat.id == chatId })
    }

    func deleteAll(forChatWithId chatId: String) throws {
        try deleteAll { entity in
            entity.chat?.id == chatId
        }
    }

}
