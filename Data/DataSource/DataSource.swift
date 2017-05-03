//
// Created by Phillipp Bertram on 03.05.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain
import RxSwift

protocol Identifiable {

    var id: String { get }

}

public protocol DataSource {

    associatedtype Entity

    func getAll() -> Single<[Entity]>

}

extension Chat: Identifiable {
}

extension Contact: Identifiable {
    var id: String {
        return userName
    }

}

extension Message: Identifiable {
}
