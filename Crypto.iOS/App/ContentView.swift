//
//  ContentView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CurrencyViewModel()
    @StateObject private var wishlistManager = WishlistManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                
                coinsList
            }
            .navigationTitle("Crypto iOS")
            .errorOverlay(viewModel.errorMessage)
        }
    }
}

private extension ContentView {
    var coinsList: some View {
        List {
            ForEach(viewModel.displayedCoins) { coin in
                NavigationLink(destination: DetailView(coin: coin)) {
                    AdaptiveCoinRowView(coin: coin, wishlistManager: wishlistManager)
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
    
    var listBackgroundColor: Color {
        Color(.systemGroupedBackground)
    }
}

#Preview {
    ContentView()
}
