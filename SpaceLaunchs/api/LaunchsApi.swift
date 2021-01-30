//
//  LaunchsApi.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

protocol LaunchsApiProtocol {
    func getLaunchs(completion: @escaping RequestCompletion<[Launch]>)
}

struct LaunchsApi: LaunchsApiProtocol {
    static let endpoint = "api.spacexdata.com"
    
    enum Path: String {
        case launches = "/v2/launches"
    }

    func getLaunchs(
        completion: @escaping RequestCompletion<[Launch]>
    ) {
        guard let url = self.prepareUrlComponents(for: .launches).url else {
            completion(nil, nil)
            fatalError("cannot Get the url")
        }
        let ressources = Resource<[Launch]>(url: url, method: .GET, successStatusCode: 200)
        NetworkManager.request(ressources, completion: completion)
    }
    
    fileprivate func prepareUrlComponents(for path: Path) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.host = LaunchsApi.endpoint
        urlComponents.scheme = "https"
        urlComponents.path = path.rawValue
        return urlComponents
    }
}
