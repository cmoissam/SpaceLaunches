//
//  Resource.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

struct Resource<T> {
    
    /// The url where the resource is located (including associated parameters).
    let url: URL
    
    /// The HTTP method to use to request this resource.
    let method: HTTPMethod
    
    /// The response status code to match against in order to decide whether the request was successful or not.
    let successStatusCode: Int
    /// Strategie used for formatting date when decoding them from JSON.
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    
    /// Strategie used for formatting keys when decoding them from JSON.
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    init(
        url: URL,
        method: HTTPMethod,
        successStatusCode: Int,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
        ) {
        self.url = url
        self.method = method
        self.successStatusCode = successStatusCode
        self.dateDecodingStrategy = dateDecodingStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
