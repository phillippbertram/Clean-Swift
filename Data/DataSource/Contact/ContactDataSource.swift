//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

protocol ContactDataSource {

    func getAll() -> Single<[Contact]>

    func get(byUserName: String) -> Single<Contact>

}
