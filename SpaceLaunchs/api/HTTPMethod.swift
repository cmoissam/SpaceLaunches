//
//  HTTPMethod.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

enum HTTPMethod: String {
    /// Requests data from a specified resource
    case GET
    /// Submits data to be processed to a specified resource
    case POST
    /// Uploads a representation of the specified URI
    case PUT
}
