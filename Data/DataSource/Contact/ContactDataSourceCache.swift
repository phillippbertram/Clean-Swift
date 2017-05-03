//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

public final class ContactDataSourceCache: DataSourceCache<Contact>, ContactDataSource {

    func get(byUserName userName: String) -> Single<Contact> {
        return get(byId: userName)
    }
}
