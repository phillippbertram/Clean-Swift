//
//  ChatRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import Common
import RxSwift

public final class ChatRepository {

    fileprivate let localDataSource: ChatDataSourceCache
    fileprivate let networkDataSource: ChatDataSourceNetwork

    public init(localDataSource: ChatDataSourceCache,
                networkDataSource: ChatDataSourceNetwork) {
        self.localDataSource = localDataSource
        self.networkDataSource = networkDataSource
    }
}

// MARK: - ChatRepositoryType

extension ChatRepository: ChatRepositoryType {

    public func observeAll() -> Observable<[Chat]> {
        let local = localDataSource.getAll().asObservable().flatMapResult()
        let remote = networkDataSource.getAll().asObservable().flatMapResult()
        return Observable
                .concat(local, remote)
                .single({ $0.isSuccess && !$0.value!.isEmpty })
                .map({ $0.value! })
    }

    public func create(chat: CreateChatParam) -> Single<Chat> {
        notImplemented()
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
        return localDataSource.get(forUserName: contact.userName)
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
        notImplemented()
        //return localDataSource.delete(chat: chat)
    }

}
