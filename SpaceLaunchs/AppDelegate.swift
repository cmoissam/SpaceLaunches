//
//  AppDelegate.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?
    let appDependencies = SharedAppDependencies()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(appDependencies: appDependencies)
        window?.rootViewController = coordinator.rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

