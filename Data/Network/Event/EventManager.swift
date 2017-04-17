//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift
import Domain

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

    private func handleEvent(_ event: EventDTO) -> Observable<Void> {
        fatalError("not implemented")
        //        switch event.type {
        //
        //            case .receivedMessage(let messageDTO):
        //                return contactRepository
        //                        .getBy(userName: messageDTO.sender)
        //                        .map { contact in
        //                            Message(dto: messageDTO, sender: contact)
        //                        }
        //                        .flatMap(messageRepository.createMessage)
        //                        .map({ _ in () })
        //        }
    }

}
