//
//  NetworkManager.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation

/// A typealias for the completion block that `NetworkManager`'s `request...` method takes.
/// - Parameters:
///   - resourceType: The parametric type of a requested resource (when the request is successful).
///   - networkError: A `NetworkError` if the request fails.
typealias RequestCompletion<T: Decodable> = (_ resourceType: T?, _ networkError: NetworkError?) -> Void

enum NetworkManager {
  
  /// Conformance to NetworkManagerProtocol that can be used by objects that want to make network requests.
  ///
  /// - Parameters:
  ///   - resource: The parametric(T) resource that is being fetched from a web service.
  ///   - completionQueue: Optional, queue where the completion will be executed, if no value is provided completion will be dispatched on an **arbitrarty queue**.
  ///   - completion: The completion block that is executed when the request finishes.
  static func request<T>(_ resource: Resource<T>, completionQueue: DispatchQueue? = DispatchQueue.main, completion: @escaping RequestCompletion<T>) {
    
    var request = URLRequest(url: resource.url)
    request.httpMethod = resource.method.rawValue
    
    let requestCompletion: RequestCompletion<T> = { result, error in
      if let queue = completionQueue {
        queue.async { completion(result,error) }
      } else {
        completion(result,error)
      }
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        // Handle all error cases
        let bridgedError = error as NSError
        let networkError: NetworkError
        switch bridgedError.code {
        case -1001: networkError = .requestTimedOut
        case -1003: networkError = .unresolvedHostname
        case -1009: networkError = .noNetwork
        default: networkError = .requestFailed("NSURLErrorDomain Code:\(bridgedError.code)")
        }
        requestCompletion(nil, networkError)
        return
      }
            
      guard let HTTPResponse = response as? HTTPURLResponse else {
        requestCompletion(nil, .invalidResponse(response))
        return
      }
      
      switch HTTPResponse.statusCode {
      case resource.successStatusCode:
        
        guard let data = data, data.count > 0 else { requestCompletion(nil, .noDataReceived); return }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = resource.dateDecodingStrategy
        do {
          let decodedModel = try jsonDecoder.decode(T.self, from: data)
          requestCompletion(decodedModel, nil)
        } catch {
          debugPrint("Parsing error : \(error)")
          requestCompletion(nil, .invalidResponseData(data))
        }
      default:
        requestCompletion(nil, .serverError(HTTPResponse.statusCode))
      }
    }
    
    task.resume()
  }
}
