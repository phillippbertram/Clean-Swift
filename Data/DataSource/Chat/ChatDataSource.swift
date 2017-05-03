//
// Created by Phillipp Bertram on 25.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

protocol ChatDataSource: DataSource {

    func get(forUserName: String) -> Single<Chat>

    func get(byId chatId: String) -> Single<Chat>

}
