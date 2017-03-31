//
//  ContactRepository.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import RxSwift

public protocol ContactRepositoryType {

    func getAllContacts() -> Observable<[Contact]>

}
