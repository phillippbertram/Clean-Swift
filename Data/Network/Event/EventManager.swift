//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
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
        switch event.type {

            case .receivedMessage(let messageDTO):
                return contactRepository
                        .getBy(userName: messageDTO.sender)
                        .map { contact in
                            Message(dto: messageDTO, sender: contact)
                        }
                        .flatMap(messageRepository.createMessage)
                        .map({ _ in () })
        }
    }

}

// MARK: - Mapping

extension Message {

    init(dto: MessageDTO, sender: Contact) {
        // Data from dto
        self.id = dto.id
        self.chatId = dto.chatId
        self.content = .text(dto.content)
        self.status = Message.Status(fromString: dto.status)
        self.sender = sender
        self.timestamp = dto.timestamp

        // defined data
        self.isIncoming = true
        self.isRead = false
        self.lastModifiedAt = Date()
    }

}

extension Message.Status {

    init(fromString raw: String) {
        switch raw {
            case "sending": self = .sending
            case "sent": self = .sent
            case "delivered": self = .delivered
            default: self = .sent
        }
    }

}
