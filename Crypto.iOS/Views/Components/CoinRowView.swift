//
//  CoinRowView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct AdaptiveCoinRowView: View {
    let coin: Currency
    let wishlistManager: WishlistManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 12) {
            coinInfoRow
            AdaptiveWishlistButton(coin: coin, wishlistManager: wishlistManager)
        }
        .adaptiveCardStyle(colorScheme: colorScheme)
    }
}

// MARK: - Private Views for Adaptive Coin Row
private extension AdaptiveCoinRowView {
    var coinInfoRow: some View {
        HStack(spacing: 5) {
            rankText
            
            coinImage
            
            coinDetails
            
            miniChart
            
            priceInfo
        }
        .font(.footnote)
    }
    
    var rankText: some View {
        Text("\(coin.marketCapRank ?? 0)")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(secondaryTextColor)
            .frame(width: 30, alignment: .leading)
    }
    
    var coinImage: some View {
        WebImage(url: coin.image)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(imageBackgroundColor)
                    .frame(width: 44, height: 44)
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(imageBorderColor, lineWidth: 0.5)
            )
    }
    
    var coinDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(coin.name ?? "Unknown")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(primaryTextColor)
                .lineLimit(2)
            
            Text(coin.symbol?.uppercased() ?? "")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(secondaryTextColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var miniChart: some View {
        MiniChartView(coin: coin)
            .frame(width: 60, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(chartBackgroundColor)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var priceInfo: some View {
        VStack(alignment: .trailing, spacing: 3) {
            Text(coin.formattedPrice)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(primaryTextColor)
            
            HStack(spacing: 2) {
                Image(systemName: coin.priceChangeIcon)
                    .font(.caption2)
                
                Text(coin.formattedPriceChange)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(coin.priceChangeColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(
                Capsule()
                    .fill(coin.priceChangeColor.opacity(0.1))
            )
        }
        .frame(minWidth: 80, alignment: .trailing)
    }
}

// MARK: - Adaptive Color Properties
private extension AdaptiveCoinRowView {
    var primaryTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var secondaryTextColor: Color {
        colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray)
    }
    
    var imageBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
    }
    
    var imageBorderColor: Color {
        colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5)
    }
    
    var chartBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray6).opacity(0.3) : Color(.systemGray6).opacity(0.5)
    }
}
