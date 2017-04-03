//
//  ChatService.swift
//  Clean
//
//  Created by Phillipp Bertram on 03/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Foundation
import RxSwift

public protocol ChatServiceType {
    
    func getChats() -> Observable<[Chat]>
    
}
