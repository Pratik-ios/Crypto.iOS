//
//  MarketDataService.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//


import Foundation

class MarketDataService {
    
    func fetchMarketData() async throws -> MarketDataModel? {
        return try await NetWorker.shared.callAPIServiceAsync(type: APIV2.globalData)
    }
    
}

extension MarketDataService {
    func fetchMarketDataWithResult(completion: @escaping(Result<MarketDataModel?, APIError>) -> Void) {
        NetWorker.shared.callAPIService(type: APIV2.globalData) { [weak self](result: Result<MarketDataModel?, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dataResponse):
                    completion(.success(dataResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        }
    }
}
