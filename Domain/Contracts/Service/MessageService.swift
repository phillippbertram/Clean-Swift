//
//  MessageService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public protocol MessageServiceType {

    func sendMessage(message: Message) -> Observable<Message>
    
}
