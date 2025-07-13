//
//  CurrencyDetailDataService.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//
import SwiftUI

class CurrencyDetailDataService {
    
    let coin: Currency
    
    init(coin: Currency) {
        self.coin = coin
    }
    
    func getCoinDetails() async throws -> CoinDetailModel {
        return try await NetWorker.shared.callAPIServiceAsync(type: APIV2.fetchCoinDetails(id: coin.id ?? ""))
    }
    
}

extension CurrencyDetailDataService {
    func getCoinDetailsWithResult(completion: @escaping (Result<[CoinDetailModel], APIError>) -> Void) {
        NetWorker.shared.callAPIService(type: APIV2.fetchCoinDetails(id: coin.id ?? "")) { [weak self] (result: Result<CoinDetailModel?, APIError>) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let dataResponse):
                    guard let dataResponse = dataResponse else {
                        completion(.failure(.invalidData))
                        return
                    }
                    completion(.success([dataResponse]))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
