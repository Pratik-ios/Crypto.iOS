//
//  DetailView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    @StateObject private var wishlistManager = WishlistManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    init(coin: Currency) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                headerSection
                wishlistSection
                chartSection
                overviewSection
                additionalDetailsSection
                linksSection
            }
        }
        .background(backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                coinSymbolView
            }
        }
    }
}

// MARK: - Header Section
private extension DetailView {
    var headerSection: some View {
        VStack(spacing: 16) {
            // Coin Image and Name
            HStack(spacing: 16) {
                WebImage(url: viewModel.coin.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .background(
                        Circle()
                            .fill(Color.gray.opacity(0.1))
                    )
                    .clipShape(Circle())
                    .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.coin.name ?? "Unknown")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(primaryTextColor)
                    
                    Text((viewModel.coin.symbol ?? "").uppercased())
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(secondaryTextColor)
                    
                    if let rank = viewModel.coin.marketCapRank {
                        HStack(spacing: 4) {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.orange)
                            Text("Rank #\(rank)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(secondaryTextColor)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Current Price
            VStack(spacing: 8) {
                Text("$\((viewModel.coin.currentPrice ?? 0).asCurrencyWith6Decimals())")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(primaryTextColor)
                
                if let change = viewModel.coin.priceChangePercentage24H {
                    HStack(spacing: 4) {
                        Image(systemName: change >= 0 ? "arrow.up.right" : "arrow.down.right")
                            .font(.caption)
                        Text("\(change.asPercentString())")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(change >= 0 ? .green : .red)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill((change >= 0 ? Color.green : Color.red).opacity(0.1))
                    )
                }
            }
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                colors: [
                    cardBackgroundColor,
                    cardBackgroundColor.opacity(0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: shadowColor, radius: 12, x: 0, y: 6)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

// MARK: - Wishlist Section
private extension DetailView {
    var wishlistSection: some View {
        DetailWishlistButton(coin: viewModel.coin, wishlistManager: wishlistManager)
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }
}

struct DetailWishlistButton: View {
    let coin: Currency
    @ObservedObject var wishlistManager: WishlistManager
    @State private var isAnimating = false
    @Environment(\.colorScheme) var colorScheme
    
    private var isInWishlist: Bool {
        wishlistManager.isInWishlist(coin.id ?? "")
    }
    
    var body: some View {
        Button(action: toggleWishlist) {
            HStack(spacing: 12) {
                Image(systemName: isInWishlist ? "heart.fill" : "heart")
                    .font(.title3)
                    .foregroundColor(isInWishlist ? .red : .blue)
                    .scaleEffect(isAnimating ? 1.3 : 1.0)
                
                Text(isInWishlist ? "Remove from Wishlist" : "Add to Wishlist")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
                
                Image(systemName: isInWishlist ? "minus.circle.fill" : "plus.circle.fill")
                    .font(.title3)
                    .foregroundColor(isInWishlist ? .red : .blue)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isInWishlist ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isInWishlist ? Color.red.opacity(0.3) : Color.blue.opacity(0.3), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isAnimating ? 0.95 : 1.0)
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 8, x: 0, y: 4)
    }
    
    private func toggleWishlist() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            wishlistManager.toggleWishlist(coin.id ?? "")
            isAnimating = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeOut(duration: 0.3)) {
                isAnimating = false
            }
        }
    }
}

// MARK: - Chart Section
private extension DetailView {
    var chartSection: some View {
        VStack(spacing: 16) {
            Text("Price Chart")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(primaryTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ChartView(coin: viewModel.coin)
                .frame(height: 300)
                .background(cardBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

// MARK: - Overview Section
private extension DetailView {
    var overviewSection: some View {
        VStack(spacing: 20) {
            SectionHeader(title: "Overview", icon: "chart.bar.fill")
            
            // Description Card
            if let description = viewModel.coinDescription, !description.isEmpty {
                DescriptionCard(
                    description: description,
                    showFullDescription: $showFullDescription
                )
            }
            
            // Statistics Grid
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticCard(stat: stat)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

// MARK: - Additional Details Section
private extension DetailView {
    var additionalDetailsSection: some View {
        VStack(spacing: 20) {
            SectionHeader(title: "Additional Details", icon: "info.circle.fill")
            
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticCard(stat: stat)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

// MARK: - Links Section
private extension DetailView {
    var linksSection: some View {
        VStack(spacing: 16) {
            SectionHeader(title: "Links", icon: "link")
            
            VStack(spacing: 12) {
                if let websiteString = viewModel.websiteURL,
                   let url = URL(string: websiteString) {
                    LinkCard(title: "Official Website", icon: "globe", url: url)
                }
                
                if let redditString = viewModel.redditURL,
                   let url = URL(string: redditString) {
                    LinkCard(title: "Reddit Community", icon: "bubble.left.and.bubble.right.fill", url: url)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 32)
    }
}
