//
//  Bootstrapper.swift
//  Clean
//
//  Created by Phillipp Bertram on 02/04/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import Swinject
import SwinjectStoryboard

final class Bootstrapper {

    static func bootstrap() -> Container {
        let container = SwinjectStoryboard.defaultContainer
        _ = try! Assembler(assemblies: [
                ViewAssembly(),
                DomainAssembly(),
                DataAssembly()], container: container)
        return container
    }

}
