//
//  API.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation

protocol API {
    var baseURL: URL { get }
    var path: String { get }
    var fullURL: URL { get }
    var method: String { get }
    var headers: [String : String]? { get }
    var parameters: [String: Any]? { get }
}
extension API {
    var fullURL: URL {
        print("BaseUrl: \(self.baseURL.absoluteString) \n Path: \(path)")
        let url = URL(string: self.baseURL.absoluteString + path) ?? URL(string: self.baseURL.absoluteString)!
        return url
                
    }
}
