//
//  DefaultNetworkService.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

class DefaultNetworkService: NetworkServiceProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /// Performs an asynchronous network request and decodes the response data
    /// into the specified type. Different from other implementations, this method uses the router to get the `URLRequest` for the object.
    ///
    /// - Parameters:
    ///   - router: An object conforming to the `URLRequestConvertible` protocol.
    ///   - type: The type into which the response data should be decoded.
    ///   - completionHandler: Method to execute after the request is finished
    ///
    /// - Returns:
    ///   The decoded data of the specified type.
    func request<T: Decodable>(_ type: T.Type, router: Router, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws {
        let urlRequest = try router.asURLRequest()
        try request(type, request: urlRequest, completionHandler: completionHandler)
    }
    
    /// Performs an asynchronous network request and decodes the response data
    /// into the specified type.
    ///
    /// - Parameters:
    ///   - router: An object conforming to the `URLRequestConvertible` protocol.
    ///   - type: The type into which the response data should be decoded.
    ///   - completionHandler: Method to execute after the request is finished
    ///
    /// - Returns:
    ///   The decoded data of the specified type.
    public func request<T: Decodable>(_ type: T.Type, request: URLRequest, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws {
        printToDebug(request)
        
        urlSession.dataTask(with: request) { [weak self] data, response, requestError in
            guard let data, let response, requestError == nil else {
                completionHandler(.failure(.generic(error: requestError)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                break
            default:
                completionHandler(.failure(.requestFailed(statusCode: httpResponse.statusCode)))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(type, from: data)
                self?.printToDebug(decodedData)
                
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.dataConversionError))
            }
        }.resume()
    }
    
    private func printToDebug(_ request: URLRequest) {
        // NOTE: In production an OSLog should be used to prevent users to see the request data when
        // plugging the phone into xcode
        #if DEBUG
        print("[REQUEST]:: START")
        dump(request)
        #endif
    }
    
    private func printToDebug<T>(_ result: T) {
        // NOTE: In production an OSLog should be used to prevent users to see the request data when
        // plugging the phone into xcode
        #if DEBUG
        print("[REQUEST]:: FINISH")
        dump(result)
        #endif
    }
}
