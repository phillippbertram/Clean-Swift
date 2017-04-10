//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import Domain

extension Contact {

    var displayName: String {
        return fullName
    }

    var fullName: String {
        let nameFormatter = PersonNameComponentsFormatter()
        var components = PersonNameComponents()
        components.givenName = firstName
        components.familyName = lastName
        return nameFormatter.string(from: components)
    }

}
