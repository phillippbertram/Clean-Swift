//
// Created by Phillipp Bertram on 31/03/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift

public final class ChatDAO: RealmBaseDAO<ChatEntity> {

    func create(withParticipant participant: ContactEntity) -> Observable<ChatEntity> {
        fatalError()
    }

    func findOrCreate(byRemoteId remoteId: String) -> (ChatEntity, Bool) {
        if let entity = find(byRemoteId: remoteId) {
            return (entity, true)
        }
        return (ChatEntity(), false)
    }

}
