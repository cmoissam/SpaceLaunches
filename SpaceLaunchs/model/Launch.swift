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
    let launchDateLocal: Date
    let details: String?
    let links: Links

    public subscript<Value>(dynamicMember keyPath: KeyPath<Links, Value>) -> Value {
        self.links[keyPath: keyPath]
    }

    var formattedDate: String {
        launchDateLocal.toString(dateFormat: .defaultDateFormat)
    }
}

extension Launch: Comparable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.flightNumber == rhs.flightNumber
    }
    
    static func < (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.launchDateLocal > rhs.launchDateLocal
    }
}
