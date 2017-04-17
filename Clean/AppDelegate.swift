//
//  AppDelegate.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import SwiftyBeaver
import Common

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let container: Container = Bootstrapper.bootstrap()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        prepareWindow()

        let seeder = container.resolve(Seeder.self)!
        _ = seeder.seedData().subscribe()

        return true
    }

    private func prepareWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()

        // disable swinject logging
        Container.loggingFunction = nil
    }

}

// MARK: - Logger

private(set) var log: SwiftyBeaver.Type = Common.log
