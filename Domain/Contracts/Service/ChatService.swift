//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation
import RxSwift

/// External service that provides all chat related data
public protocol ChatServiceType {

    /// Gets all available chats.
    ///
    /// - Returns: Observable.
    func getChats() -> Observable<[Chat]>

}
