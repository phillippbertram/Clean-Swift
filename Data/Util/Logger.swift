//
//  Logger.swift
//  Clean-Swift
//
//  Created by Phillipp Bertram on 08/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import SwiftyBeaver

private(set) var log: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self

    let console = ConsoleDestination()
    log.addDestination(console)

    return log
}()
