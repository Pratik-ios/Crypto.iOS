//
//  DataServices.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//
import SwiftUI

class CurrencyDataService {
        
    func fetchCoins() async throws -> [Currency] {
        return try await NetWorker.shared.callAPIServiceAsync(type: APIV2.fetchCoins)
    }
    
}

extension CurrencyDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[Currency], APIError>) -> Void) {
        NetWorker.shared.callAPIService(type: APIV2.fetchCoins) { [weak self](result: Result<[Currency]?, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dataResponse):
                    completion(.success(dataResponse ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        }
    }
    
}
