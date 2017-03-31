//
//  UseCase.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public final class SendMessageUseCase {

    public enum MessageResult {
        case sending(progress: Double)
    }
    
    private let createChatUseCase: CreateChatUseCase
    
    init(createChatUseCase: CreateChatUseCase) {
        self.createChatUseCase = createChatUseCase
    }
    
    public func build(userName: String) -> Observable<MessageResult> {
        return Observable.create { observer in
            
            Thread.sleep(forTimeInterval: 0.5)
            observer.on(.next(.sending(progress: 0)))
            Thread.sleep(forTimeInterval: 0.5)
            observer.on(.next(.sending(progress: 0.25)))
            Thread.sleep(forTimeInterval: 0.5)
            observer.on(.next(.sending(progress: 0.50)))
            Thread.sleep(forTimeInterval: 0.5)
            observer.on(.next(.sending(progress: 0.75)))
            Thread.sleep(forTimeInterval: 0.5)
            
            observer.on(.completed)
            return Disposables.create()
        }
    }

}
