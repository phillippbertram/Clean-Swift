//
// Created by Phillipp Bertram on 23.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Foundation

public extension String {

    public init(optional: CustomStringConvertible?) {
        if let unwrapped = optional {
            self = unwrapped.description
        } else {
            self = ""
        }
    }

}