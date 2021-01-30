//
//  AppCoordinator.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

protocol AppRoutingLogic: class {
    func showLaunchDetailsViewController(launch: Launch)
}

class AppCoordinator: AppRoutingLogic {
    
    let rootViewController = AppNavigationController()
    let appDependencies: SharedRootContainer
    
    init(appDependencies: SharedRootContainer) {
        self.appDependencies = appDependencies
        self.rootViewController.viewControllers = [appDependencies.makeLaunchsListViewController(coordinator: self)]
    }
    
    func showLaunchDetailsViewController(launch: Launch) {
        let vc = appDependencies.makeLaunchDetailsViewController(launch: launch)
        rootViewController.pushViewController(vc, animated: true)
    }
}

class AppNavigationController: UINavigationController {
    
    // MARK :- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .white
        navigationBar.barStyle = .black
        navigationBar.backgroundColor = .systemBlue
    }
}
