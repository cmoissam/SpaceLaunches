//
//  LaunchsService.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

/// Enum containing errors for LaunchsService
enum LaunchsServiceError: Error {
    /// Error to get remoteData
    case remoteServiceError
    /// Error for no data retrieved
    case noData
}

/// Result of listing service call
enum LaunchsServiceResult {
    case failure(_ error: LaunchsServiceError)
    case success(launchs: [Launch])
}

protocol LaunchsServiceProtocol {
    func getRemoteData(completion: @escaping (LaunchsServiceResult) -> Void)
}

class LaunchsService: LaunchsServiceProtocol {
    private let launchsApi: LaunchsApiProtocol
    
  public init(launchsApi: LaunchsApiProtocol) {
        self.launchsApi = launchsApi
    }
    
    /// getRemoteData: get data of advertisements and categories from api
    /// - Parameter completion: The completion block that is executed when the service finishes.
    ///
    public func getRemoteData(
        completion: @escaping (LaunchsServiceResult) -> Void
    ) {
        self.launchsApi.getLaunchs { launchs, error in
            guard error == nil else {
                completion(.failure(.remoteServiceError))
                return
            }
            guard let safeLaunchs = launchs, !safeLaunchs.isEmpty else {
                completion(.failure(.noData))
                return
            }
            completion(.success(launchs: safeLaunchs))
        }
    }
}
