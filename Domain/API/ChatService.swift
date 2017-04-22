//
// Created by Phillipp Bertram on 22.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

protocol ChatService {

    func getAll() -> Single<[ChatDTO]>

    func get(byId: String) -> Single<ChatDTO>

}
