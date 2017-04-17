//
// Created by Phillipp Bertram on 31/03/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift

public final class ChatDAO: RealmBaseDAO<ChatEntity> {

    private let messageDAO: MessageDAO

    public init(config: Realm.Configuration, messageDAO: MessageDAO) {
        self.messageDAO = messageDAO
        super.init(config: config)
    }

    func create(withParticipant participant: ContactEntity) -> Observable<ChatEntity> {
        fatalError()
    }

    func findOrCreate(byRemoteId remoteId: String) -> (ChatEntity, Bool) {
        if let entity = find(byRemoteId: remoteId) {
            return (entity, true)
        }
        return (ChatEntity(), false)
    }

    // MARK: - Delete

    override func delete(entity chatEntity: ChatEntity) throws {
        try messageDAO.deleteAll(forChatWithId: chatEntity.id)
        try super.delete(entity: chatEntity)
    }

    override func delete(byId primaryKey: String) throws {
        try messageDAO.deleteAll(forChatWithId: primaryKey)
        try super.delete(byId: primaryKey)
    }

    override func deleteAll() throws {
        try messageDAO.deleteAll()
        try super.deleteAll()
    }

}
