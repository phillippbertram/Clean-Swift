//
// Created by Phillipp Bertram on 15.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import Data

class ChatDaoSpec: QuickSpec {

    override func spec() {
        describe("ChatDao") {

            var sut: ChatDao!

            beforeEach {
                let config = Realm.Configuration.test(withName: self.name)
                sut = ChatDao(config: config)
            }

            beforeEach {

                let realm = sut.getRealm()
                realm.beginWrite()
                let chat1 = ChatEntity()
                let chat2 = ChatEntity()
                let chat3 = ChatEntity()
                realm.add(chat1)
                realm.add(chat2)
                realm.add(chat3)
                try! realm.commitWrite()

            }

            context("finding") {

                context("findAll") {

                    it("should return all entities") {
                        let result = sut.findAll()
                        expect(result.count) == 3
                    }

                }

            }

        }
    }

}
