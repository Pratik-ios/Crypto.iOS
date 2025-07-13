//
//  WishlistTabView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct WishlistTabView: View {
    @StateObject private var viewModel = CurrencyViewModel()
    @EnvironmentObject var wishlistManager: WishlistManager
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var systemColorScheme
    
    private var wishlistCoins: [Currency] {
        viewModel.coins.filter { coin in
            wishlistManager.isInWishlist(coin.id ?? "")
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if wishlistManager.wishlistCoinIds.isEmpty {
                    EmptyWishlistView()
                } else {
                    wishlistContent
                }
            }
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !wishlistManager.wishlistCoinIds.isEmpty {
                        clearAllButton
                    }
                    
                }
            }
        }
        .onAppear {
            
            if viewModel.coins.isEmpty {
                Task {
                    await viewModel.refreshData()
                }
            }
        }
    }
    
    private var wishlistContent: some View {
        List {
            
            WishlistSummaryCard(coins: wishlistCoins)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            
            
            ForEach(wishlistCoins) { coin in
                NavigationLink(destination: DetailView(coin: coin)) {
                    WishlistCoinRow(coin: coin, wishlistManager: wishlistManager)
                }
                .listRowModifiers()
            }
        }
        .listStyle(.plain)
        .background(listBackgroundColor)
        .refreshable {
            await viewModel.refreshData()
        }
    }
    
    private var clearAllButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                wishlistManager.wishlistCoinIds.removeAll()
                wishlistManager.saveWishlist()
            }
        }) {
            Text("Clear All")
                .font(.caption)
                .foregroundColor(.red)
        }
    }
    
    private var listBackgroundColor: Color {
        let currentScheme = themeManager.currentTheme.colorScheme ?? systemColorScheme
        return currentScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground)
    }
}
