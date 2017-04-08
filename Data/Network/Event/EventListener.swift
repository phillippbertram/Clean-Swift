//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import RxSwift

public protocol EventListenerType {

    func startListening() -> Observable<EventDTO>

}
