//
// Created by Phillipp Bertram on 31/03/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift

public final class ChatEntity: RemoteEntity {

    dynamic var participant: ContactEntity!

    convenience init(participant: ContactEntity) {
        self.init()
        self.participant = participant
    }

}
