//
//  WishlistManager.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import SwiftUI

class WishlistManager: ObservableObject {
    static let shared = WishlistManager()
    
    @Published var wishlistCoinIds: Set<String> = []
    
    private let userDefaults = UserDefaults.standard
    private let wishlistKey = "CryptoWishlist"
    
    private init() {
        loadWishlist()
    }
    
    private func loadWishlist() {
        if let data = userDefaults.data(forKey: wishlistKey),
           let coinIds = try? JSONDecoder().decode(Set<String>.self, from: data) {
            self.wishlistCoinIds = coinIds
        }
    }
    
    func saveWishlist() {
        if let data = try? JSONEncoder().encode(wishlistCoinIds) {
            UserDefaults.standard.set(data, forKey: wishlistKey)
        }
    }
    
    func isInWishlist(_ coinId: String) -> Bool {
        return wishlistCoinIds.contains(coinId)
    }
    
    func addToWishlist(_ coinId: String) {
        wishlistCoinIds.insert(coinId)
        saveWishlist()
    }
    
    func removeFromWishlist(_ coinId: String) {
        wishlistCoinIds.remove(coinId)
        saveWishlist()
    }
    
    func toggleWishlist(_ coinId: String) {
        if isInWishlist(coinId) {
            removeFromWishlist(coinId)
        } else {
            addToWishlist(coinId)
        }
    }
}
