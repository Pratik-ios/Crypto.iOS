//
//  CurrencyViewModel.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation
import SwiftUI

@MainActor
class CurrencyViewModel: ObservableObject {
    
    @Published var coins = [Currency]()
    @Published var displayedCoins = [Currency]()
    @Published var market: MarketDataModel? = nil
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            updateDisplayedCoins()
        }
    }
    
    private let service = CurrencyDataService()
    private let marketDataService = MarketDataService()
    
    init() {
        Task {
            do {
                try await fetchCoins()
                try await fetchMarket()
                updateDisplayedCoins()
            } catch {
                print("Error fetching coins: \(error)")
            }
        }
    }
    
    func fetchCoins() async throws {
        self.coins = try await service.fetchCoins()
    }
    
    func fetchMarket() async throws {
        self.market = try await marketDataService.fetchMarketData()
    }
    
    func fetchCoinsWithCompletionHandler() {
        service.fetchCoinsWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchMarketDataWithCompletionHandler() {
        marketDataService.fetchMarketDataWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let market):
                    self?.market = market
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func updateDisplayedCoins() {
        if searchText.isEmpty {
            displayedCoins = coins
        } else {
            let lowercasedText = searchText.lowercased()
            displayedCoins = coins.filter { coin in
                (coin.name ?? "").lowercased().contains(lowercasedText) ||
                (coin.symbol ?? "").lowercased().contains(lowercasedText) ||
                (coin.id ?? "").lowercased().contains(lowercasedText)
            }
        }
    }
    
    func refreshData() async {
        errorMessage = nil
        do {
            coins = try await service.fetchCoins()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

extension Currency {
    var formattedPrice: String {
        "$\((currentPrice ?? 0).asCurrencyWith6Decimals())"
    }
    
    var formattedPriceChange: String {
        "\(abs(priceChangePercentage24H ?? 0).asPercentString())"
    }
    
    var priceChangeColor: Color {
        (priceChangePercentage24H ?? 0) >= 0 ? .green : .red
    }
    
    var priceChangeIcon: String {
        (priceChangePercentage24H ?? 0) >= 0 ? "arrow.up" : "arrow.down"
    }
}
