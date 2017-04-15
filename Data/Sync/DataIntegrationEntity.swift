//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RealmSwift
import RxSwift
import Domain

//final class Integration {
//
//    fileprivate let chatAPI: ChatAPI
//    fileprivate let chatDao: ChatDao
//
//    fileprivate let contactAPI: ContactAPI
//    fileprivate let contactDao: ContactDao
//
//    fileprivate let currentUserRepository: CurrentUserRepositoryType
//
//    init(chatAPI: ChatAPI,
//         chatDao: ChatDao,
//         contactAPI: ContactAPI,
//         contactDao: ContactDao,
//         currentUserRepository: CurrentUserRepositoryType) {
//        self.chatAPI = chatAPI
//        self.chatDao = chatDao
//        self.contactAPI = contactAPI
//        self.contactDao = contactDao
//        self.currentUserRepository = currentUserRepository
//    }
//
//    func importAllChats() -> Observable<[ChatEntity]> {
//        return chatAPI
//                .getChats()
//                .flatMap({ Observable.from($0) })
//                .flatMap { [unowned self] chatDto in
//                    self.currentUserRepository.getCurrentUser().map({ ($0, chatDto) })
//                }
//                .flatMap { [unowned self] (currentUser, chatDto) -> Observable<(ChatDTO, ContactEntity)> in
//                    let participantName = chatDto.participantName(currentUser: currentUser)
//                    if let contact = self.contactDao.find(byUserName: participantName) {
//                        return Observable.just((chatDto, contact))
//                    }
//                    return self.getContact(byUserName: participantName).map({(chatDto, $0)})
//                }
//                .flatMap { [unowned self] (chatDto, contact) in
//                    self.chatDao.write { [unowned self] () -> Observable<ChatEntity> in
//                        let (entity, created) = self.chatDao.findOrCreate(byRemoteId: chatDto.id)
//                        entity.remoteId = chatDto.id
//                        entity.createdAt = chatDto.createdAt
//                        entity.modifiedAt = chatDto.modifiedAt
//                        if created {
//                            entity.participant = contact
//                        }
//                        return entity
//                    }
//                }
//                .toArray()
//    }
//
//    func importContact(contactDTO: ContactDTO) -> Observable<ContactEntity> {
//        return contactDao.write {
//            let entity: ContactEntity = {
//                if let entity = self.contactDao.find(byUserName: contactDTO.userName) {
//                    return entity
//                }
//                return ContactEntity()
//            }()
//            entity.remoteId = contactDTO.userName
//            entity.firstName = contactDTO.firstName
//            entity.lastName = contactDTO.lastName
//            return entity
//        }
//    }
//
//    private func getContact(byUserName userName: String) -> Observable<ContactEntity> {
//        return Observable.deferred { [unowned self] in
//            if let contact = self.contactDao.find(byUserName: userName) {
//                return Observable.just(contact)
//            }
//            return self.contactAPI
//                    .get(byId: userName)
//                    .flatMap { [unowned self] contactDTO in
//                        self.importContact(contactDTO: contactDTO)
//                        
//                }
//        }
//    }
//
//}
