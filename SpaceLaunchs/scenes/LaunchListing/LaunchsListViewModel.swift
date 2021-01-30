//
//  LaunchsListViewModel.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

class LaunchsListViewModel {
    
    enum DisplayContext {
        case loading
        case success
        case noData
        case updated
    }
    
    var launchs = [Launch]()
    var status: Observable<DisplayContext> = Observable<DisplayContext>(value: .loading)
    
    func update(
        status: DisplayContext,
        launchs: [Launch] = []
    ) {
        if status == .success {
            self.launchs = launchs
        }
        self.status.value = status
    }
}

