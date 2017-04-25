//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public protocol RemoteEntityType {

    var remoteId: String? { get set }

}

public class RemoteEntity: BaseEntity, RemoteEntityType {

    public dynamic var remoteId: String?

    public override static func indexedProperties() -> [String] {
        return ["remoteId"]
    }

}
