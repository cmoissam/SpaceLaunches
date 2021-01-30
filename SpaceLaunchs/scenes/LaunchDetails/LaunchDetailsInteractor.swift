//
//  LaunchDetailsInteractor.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

protocol LaunchDetailsUseCase {
    var viewModel: Observable<LaunchDetailsViewModel> { get }
}

class LaunchDetailsInteractor: LaunchDetailsUseCase {
    var viewModel: Observable<LaunchDetailsViewModel>
    
    init(viewModel: LaunchDetailsViewModel) {
        self.viewModel = Observable(value: viewModel)
    }
}
