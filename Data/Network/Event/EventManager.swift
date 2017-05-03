//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain
import Common

class ImportReceivedMessageUseCase {

    func build(message: Message) -> Observable<Message> {
        return Observable.empty()
    }

}

public protocol EventManagerType {

    func startListening() -> Observable<Void>
}

public final class EventManager: EventManagerType {

    private let eventListener: EventListenerType
    private var contactRepository: ContactRepositoryType!
    private var messageRepository: MessageRepositoryType!

    init(eventListener: EventListenerType) {
        self.eventListener = eventListener
    }

    public func startListening() -> Observable<Void> {
        return eventListener
                .startListening()
                .flatMap(handleEvent)
    }

    private func handleEvent(_ event: ApiEvent) -> Observable<Void> {
        notImplemented()
    }

}
