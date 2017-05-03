//
// Created by Phillipp Bertram on 02.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

protocol MessageService {

    func send(message: String, toReceiver receiver: String) -> Completable

}
