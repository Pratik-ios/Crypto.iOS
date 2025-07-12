//
//  NetWorker.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation
import UIKit

class NetWorker {
    static let shared = NetWorker()
    
    public var showHud: () -> Void = {}
    public var hideHud: () -> Void = {}
    
    private func requestFromAuthType(_ api: API) -> URLRequest {
        var request = URLRequest(url: api.fullURL)
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        // Set the timeout interval (in seconds)
        request.timeoutInterval = 60.0
        
        if api.method == "POST", let parameters = api.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            } catch {
                print("Error serializing JSON: \(error)")
            }
        }
        
        print("url- \(api.fullURL)")
        print("method- \(api.method)")
        print("headers- \(api.headers ?? [:])")
        
        return request
    }
    
    public func callAPIService<T: Codable>(type: API, completion: @escaping (Result<T?, APIError>) -> Void) {
        let request = requestFromAuthType(type)
        
        if shouldShowHUD(for: type) {
            self.showHud()
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknownedError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                print("--- Entering Response ---")
                let responseString = String(data: data, encoding: .utf8) ?? ""
                                    
                print(responseString)

                let coins = try JSONDecoder().decode(T.self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
            
        }.resume()

    }
    
    public func callAPIServiceAsync<T: Codable>(type: API) async throws -> T {
        let request = requestFromAuthType(type)
        
        if shouldShowHUD(for: type) {
            await MainActor.run {
                self.showHud()
            }
        }
        
        defer {
            if shouldShowHUD(for: type) {
                Task { @MainActor in
                    self.hideHud()
                }
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print("--- Entering Response ---")
            let responseString = String(data: data, encoding: .utf8) ?? ""
                                
            print(responseString)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.requestFailed(description: "Request failed")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw APIError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
            
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknownedError(error: error)
        }
    }
    
    private func shouldShowHUD(for api: API) -> Bool {
        return true
    }
        
}
