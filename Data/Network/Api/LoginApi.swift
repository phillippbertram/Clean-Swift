//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import RxSwift

public protocol LoginApiType {

    func login(with userName: String, and password: String) -> Single<ApiLogin>

}

public final class LoginApi {

    fileprivate var data: Set<ApiLogin> = []

    public init() {
        let pbe = ApiLogin(userName: "pbe", firstName: "Phillipp", lastName: "Bertram")
        let alb = ApiLogin(userName: "alb", firstName: "Alexander", lastName: "Brechmann")
        let nih = ApiLogin(userName: "nih", firstName: "Nils", lastName: "Hohmann")
        let waw = ApiLogin(userName: "waw", firstName: "Waldemar", lastName: "Weißhaar")
        let cwo = ApiLogin(userName: "cwo", firstName: "Christof", lastName: "Wolke")
        let mdr = ApiLogin(userName: "mdr", firstName: "Matthias", lastName: "Dierker")

        data.insert(pbe)
        data.insert(alb)
        data.insert(nih)
        data.insert(waw)
        data.insert(cwo)
        data.insert(mdr)
    }

}

extension LoginApi: LoginApiType {

    public func login(with userName: String, and password: String) -> Single<ApiLogin> {
        return Single.deferred { [unowned self] in

            guard let user = self.data.filter({ $0.userName == userName }).first else {
                return Single.error(ApiError.invalidCredentials)
            }

            guard user.userName == password else {
                return Single.error(ApiError.invalidCredentials)
            }

            return Single.just(user)
        }
    }
}
