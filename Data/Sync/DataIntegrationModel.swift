////
//// Created by Phillipp Bertram on 15.04.17.
//// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
////
//
//import RxSwift
//import Domain
//
//protocol DataIntegration {
//
//    func importChats() -> Observable<[Chat]>
//
//}
//
//final class DataIntegrationModel: DataIntegration {
//
//    fileprivate let chatAPI: ChatAPI
//    fileprivate let contactAPI: ContactAPI
//
//    fileprivate let chatRepo: ChatRepositoryType
//    fileprivate let messageRepo: MessageRepositoryType
//    fileprivate let contactRepo: ContactRepositoryType
//    fileprivate let accountRepo: AccountRepositoryType
//
//    init(chatAPI: ChatAPI,
//         contactAPI: ContactAPI,
//         chatRepo: ChatRepositoryType,
//         messageRepo: MessageRepositoryType,
//         contactRepo: ContactRepositoryType,
//         accountRepo: AccountRepositoryType) {
//        self.chatAPI = chatAPI
//        self.contactAPI = contactAPI
//        self.chatRepo = chatRepo
//        self.contactRepo = contactRepo
//        self.accountRepo = accountRepo
//        self.messageRepo = messageRepo
//    }
//
//    func importChats() -> Single<[Chat]> {
//        return chatAPI
//                .getChats()
//                .asObservable()
//                .flatMap {
//                    return Observable.from($0)
//                }
//                .flatMap { [unowned self] chatDTO in
//                    return Observable
//                        .combineLatest(self.accountRepo.getCurrentUser().asObservable(), 
//                                       Observable.just(chatDTO))
//                }
//                .flatMap { [unowned self] (currentUser, chatDTO) -> Observable<(Contact, ChatDTO)> in
//                    let participantName = chatDTO.participantName(currentUser: currentUser)
//                    let getContact = self.importContact(byUserName: participantName)
//                    return Observable.combineLatest(getContact, Observable.just(chatDTO))
//                }
//                .map { (participant, chatDTO) -> Chat in
//                    let chat = Chat(id: chatDTO.id,
//                                    participant: participant,
//                                    lastMessage: nil,
//                                    modifiedAt: chatDTO.modifiedAt,
//                                    createdAt: chatDTO.createdAt)
//                    return chat
//            }
//    }
//
//    func importContact(byUserName: String) -> Observable<Contact> {
//        return contactAPI
//                .get(byId: byUserName)
//                .map { contactDTO in
//                    return CreateContactParam(userName: contactDTO.userName,
//                                   firstName: contactDTO.firstName,
//                                   lastName: contactDTO.lastName)
//                }
//                .flatMap { [unowned self] contact in
//                    return self.contactRepo.create(params: contact)
//                }.asObservable()
//    }
//
//    func importMessageDTO(_ messageDTO: MessageDTO) -> Observable<Message> {
//        return self.importContact(byUserName: messageDTO.sender)
//            .flatMap { [unowned self] in
//                Observable.combineLatest(Observable.just($0), self.accountRepo.getCurrentUser().asObservable())
//            }
//            .flatMap { [unowned self] sender, currentUser -> Observable<Message> in
//                let param = CreateMessageParam(chatId: messageDTO.chatId,
//                                               content: .text(messageDTO.content),
//                                               status: .delivered, //Message.Status(fromString: messageDTO.status),
//                                               sender: sender,
//                                               isIncoming: sender.userName != currentUser.userName,
//                                               isRead: true,
//                                               timestamp: Date())
//                return self.messageRepo.create(message: param).asObservable()
//        }
//    }
//
//}
//
//final class MessageDTODomainMapper {
//
//    func map(dto: MessageDTO, message: Message) -> Message {
//        return message
//    }
//
//}
