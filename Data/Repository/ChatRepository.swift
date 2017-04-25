//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

public final class ChatRepository {

    fileprivate let localDataSource: ChatDataSourceLocal
    fileprivate let networkDataSource: ChatDataSourceNetwork

    public init(localDataSource: ChatDataSourceLocal,
                networkDataSource: ChatDataSourceNetwork) {
        self.localDataSource = localDataSource
        self.networkDataSource = networkDataSource
    }
}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func observeAll() -> Observable<[Chat]> {
        return localDataSource.observeAll()
    }

    public func create(chat: CreateChatParam) -> Single<Chat> {
        return localDataSource.persist(chat: chat)
    }

    public func get(byId chatId: String) -> Single<Chat> {
        let local = localDataSource.get(byId: chatId).asObservable().flatMapResult()
        let remote = networkDataSource.get(byId: chatId).asObservable().flatMapResult()
        return Observable
                .concat(local, remote)
                .single({ $0.isSuccess })
                .map({ $0.value! })
                .take(1)
                .asSingle()
    }

    public func get(forContact contact: Contact) -> Single<Chat> {
        let local = localDataSource.get(forContact: contact).asObservable().flatMapResult()
        return Observable
                .concat(local)
                .single({ $0.isSuccess })
                .map({ $0.value! })
                .take(1)
                .asSingle()
    }

    public func getAll() -> Single<[Chat]> {
        let local = localDataSource.getAll().asObservable().flatMapResult()
        let remote = networkDataSource.getAll().asObservable().flatMapResult()
        return Observable
                .concat(local, remote)
                .single({ $0.isSuccess })
                .map({ $0.value! })
                .take(1)
                .asSingle()
    }

    // MARK: Deleting

    public func delete(chat: Chat) -> Completable {
        return localDataSource.delete(chat: chat)
    }

}
