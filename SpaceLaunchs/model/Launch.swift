//
//  Launch.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

@dynamicMemberLookup
struct Launch: Codable {
    let flightNumber: Int
    let missionName: String
    let launchDate: Date
    let details: String?
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDate = "launch_date_local"
        case details = "details"
        case links = "links"
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<Links, Value>) -> Value {
        self.links[keyPath: keyPath]
    }

    var formattedDate: String {
        launchDate.toString(dateFormat: .defaultDateFormat)
    }
}

extension Launch: Comparable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.flightNumber == rhs.flightNumber
    }
    
    static func < (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.launchDate > rhs.launchDate
    }
}
