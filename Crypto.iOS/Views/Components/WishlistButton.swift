//
//  WishlistButton.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import SwiftUI

struct AdaptiveWishlistButton: View {
    let coin: Currency
    @ObservedObject var wishlistManager: WishlistManager
    @State private var isAnimating = false
    @Environment(\.colorScheme) var colorScheme
    
    private var isInWishlist: Bool {
        wishlistManager.isInWishlist(coin.id ?? "")
    }
    
    var body: some View {
        Button(action: toggleWishlist) {
            HStack(spacing: 10) {
                heartIcon
                buttonText
                Spacer()
                actionIcon
            }
            .foregroundColor(buttonTextColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(buttonBackground)
            .overlay(buttonBorder)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isAnimating ? 0.95 : 1.0)
    }
    
    private var heartIcon: some View {
        Image(systemName: isInWishlist ? "heart.fill" : "heart")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(isInWishlist ? .red : buttonAccentColor)
            .scaleEffect(isAnimating ? 1.3 : 1.0)
    }
    
    private var buttonText: some View {
        Text(isInWishlist ? "Remove from Wishlist" : "Add to Wishlist")
            .font(.caption)
            .fontWeight(.medium)
    }
    
    private var actionIcon: some View {
        Image(systemName: isInWishlist ? "minus.circle" : "plus.circle")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(isInWishlist ? .red : buttonAccentColor)
    }
    
    private var buttonBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(isInWishlist ? removeBackgroundColor : addBackgroundColor)
    }
    
    private var buttonBorder: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(isInWishlist ? removeBorderColor : addBorderColor, lineWidth: 1)
    }
    
    private func toggleWishlist() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
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

// MARK: - Wishlist Button Colors
private extension AdaptiveWishlistButton {
    var buttonTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var buttonAccentColor: Color {
        .blue
    }
    
    var addBackgroundColor: Color {
        colorScheme == .dark
            ? Color.blue.opacity(0.15)
            : Color.blue.opacity(0.1)
    }
    
    var removeBackgroundColor: Color {
        colorScheme == .dark
            ? Color.red.opacity(0.15)
            : Color.red.opacity(0.1)
    }
    
    var addBorderColor: Color {
        colorScheme == .dark
            ? Color.blue.opacity(0.4)
            : Color.blue.opacity(0.3)
    }
    
    var removeBorderColor: Color {
        colorScheme == .dark
            ? Color.red.opacity(0.4)
            : Color.red.opacity(0.3)
    }
}
