//
//  Bootstrapper.swift
//  Clean
//
//  Created by Phillipp Bertram on 02/04/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Swinject
import SwinjectStoryboard

final class Bootstrapper {

    static func bootstrap() -> Container {
        let container = SwinjectStoryboard.defaultContainer
        let assembler = Assembler(container: container)
        assembler.apply(assemblies: [
            ViewAssembly(),
            DomainAssembly(),
            DataAssembly()])
        return container
    }

}
