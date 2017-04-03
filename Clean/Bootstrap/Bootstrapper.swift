//
//  Bootstrapper.swift
//  Clean
//
//  Created by Phillipp Bertram on 02/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Swinject

final class Bootstrapper {
    
    static func bootstrap() -> Container {
        let container = Container()
        _ = try! Assembler(assemblies: [ViewAssembly(), DomainAssembly()], container: container)
        return container
    }
    
}
