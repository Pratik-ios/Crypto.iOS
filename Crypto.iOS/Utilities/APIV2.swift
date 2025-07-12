//
//  APIV2.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation

enum APIV2: API {
    case fetchCoins
    
    case fetchCoinDetails(id: String)
    
    case globalData
}

extension APIV2 {
    var baseURL: URL {
        switch self {
        case .fetchCoins:
            return URL(string: Router.baseUrl) ?? URL(fileURLWithPath: "")
            
        case .fetchCoinDetails:
            return URL(string: Router.baseUrl) ?? URL(fileURLWithPath: "")
            
        case .globalData:
            return URL(string: Router.baseUrl) ?? URL(fileURLWithPath: "")

        }
    }
    
    var path: String {
        switch self {
        case .fetchCoins:
            return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h&locale=en"
            
        case .fetchCoinDetails(id: let id):
            return "coins/\(id)?localization=true&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=true"
            
        case .globalData:
            return "global"
        }
    }
    
    
    var method: String {
        switch self {
        case .fetchCoins:
            return "GET"
            
        case .fetchCoinDetails:
            return "GET"
            
        case .globalData:
            return "GET"
            
        }
    }
}

extension APIV2 {
    var headers: [String : String]? {
        
        switch self {
        case .fetchCoins:
            return ["Content-Type" : "application/json",
                    "x-cg-demo-api-key": Router.demoGeckoKey]
            
        case .fetchCoinDetails:
            return ["Content-Type" : "application/json",
                    "x-cg-demo-api-key": Router.demoGeckoKey]
            
        case .globalData:
            return ["Content-Type" : "application/json",
                    "x-cg-demo-api-key": Router.demoGeckoKey]
            
        }
    }
}

extension APIV2 {
    var parameters: [String : Any]? {
        switch self {
            
        case .fetchCoins:
            return [:]
            
        case .fetchCoinDetails:
            return [:]
            
        case .globalData:
            return [:]
            
        }
    }
}
