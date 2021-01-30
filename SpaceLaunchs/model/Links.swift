//
//  Links.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

struct Links: Codable {
    let missionPatchSmall: String?
    let youtubeID: String
    
    enum CodingKeys: String, CodingKey {
        case missionPatchSmall = "mission_patch_small"
        case youtubeID = "youtube_id"
    }
}
