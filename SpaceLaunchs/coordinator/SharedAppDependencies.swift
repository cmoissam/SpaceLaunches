//
//  SharedAppDependencies.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

protocol SharedRootContainer: class {
    func makeLaunchsListViewController(coordinator: AppRoutingLogic) -> UIViewController
    func makeLaunchDetailsViewController(launch: Launch) -> UIViewController
}

class SharedAppDependencies: SharedRootContainer {
    private let launchsApi: LaunchsApiProtocol
    private let launchsService: LaunchsServiceProtocol
    
    init() {
        self.launchsApi = LaunchsApi()
        self.launchsService = LaunchsService(launchsApi: self.launchsApi)
    }
    
    func makeLaunchsListViewController(coordinator: AppRoutingLogic) -> UIViewController {
        UIViewController()
    }

    func makeLaunchDetailsViewController(launch: Launch) -> UIViewController {
        UIViewController()
    }
}
