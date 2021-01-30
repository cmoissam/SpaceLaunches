//
//  LaunchsListInteractor.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

protocol LaunchsListUseCase {
    var viewModel: LaunchsListViewModel { get }
    func fetchData()
}

class LaunchsListInteractor: LaunchsListUseCase {
    var viewModel: LaunchsListViewModel = LaunchsListViewModel()
    private let launchsService: LaunchsServiceProtocol

    internal init(launchsService: LaunchsServiceProtocol) {
        self.launchsService = launchsService
    }

    func fetchData() {
        self.viewModel.update(status: .loading)
        launchsService.getRemoteData { [weak self] result in
            switch result {
            case .success(let launchs):
                self?.viewModel.update(
                    status: .success,
                    launchs: launchs
                )
            case .failure(_):
                self?.viewModel.update(status: .noData)
            }
        }
    }
}
