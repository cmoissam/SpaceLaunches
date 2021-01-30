//
//  LaunchDetailsViewModel.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

struct LaunchDetailsViewModel {
    
    let name: String
    let description: String
    let creationDate: String
    let videoLink: URL?
    
    init(
        launch: Launch
    ) {
        self.name = launch.missionName
        self.description = launch.details ?? ""
        self.creationDate = launch.formattedDate
        self.videoLink = URL(string: "https://www.youtube.com/embed/\(launch.youtubeId)")
    }
}
