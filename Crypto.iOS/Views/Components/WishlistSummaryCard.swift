struct WishlistSummaryCard: View {
    let coins: [Currency]
    @Environment(\.colorScheme) var colorScheme
    
    private var totalValue: Double {
        coins.compactMap { $0.currentPrice }.reduce(0, +)
    }
    
    private var totalChange: Double {
        let changes = coins.compactMap { $0.priceChangePercentage24H }
        return changes.isEmpty ? 0 : changes.reduce(0, +) / Double(changes.count)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Portfolio Overview")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(primaryTextColor)
                    
                    Text("\(coins.count) cryptocurrencies")
                        .font(.caption)
                        .foregroundColor(secondaryTextColor)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("$\(totalValue, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(primaryTextColor)
                    
                    HStack(spacing: 4) {
                        Image(systemName: totalChange >= 0 ? "arrow.up" : "arrow.down")
                            .font(.caption2)
                        Text("\(abs(totalChange), specifier: "%.2f")%")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(totalChange >= 0 ? .green : .red)
                }
            }
        }
        .padding(20)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
        .padding(.horizontal, 8)
        .padding(.top, 8)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
    }
    
    private var primaryTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var secondaryTextColor: Color {
        colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray)
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.4) : Color.black.opacity(0.1)
    }
}

// MARK: - Wishlist Coin Row
struct WishlistCoinRow: View {
    let coin: Currency
    @ObservedObject var wishlistManager: WishlistManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            // Coin Image
            WebImage(url: coin.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(imageBackgroundColor)
                        .frame(width: 48, height: 48)
                )
                .clipShape(Circle())
            
            // Coin Details
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name ?? "Unknown")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(primaryTextColor)
                    .lineLimit(1)
                
                Text(coin.symbol?.uppercased() ?? "")
                    .font(.caption)
                    .foregroundColor(secondaryTextColor)
            }
            
            Spacer()
            
            // Price Info
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\((coin.currentPrice ?? 0), specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(primaryTextColor)
                
                HStack(spacing: 2) {
                    Image(systemName: coin.priceChangeIcon)
                        .font(.caption2)
                    Text("\(abs(coin.priceChangePercentage24H ?? 0), specifier: "%.2f")%")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(coin.priceChangeColor)
            }
            
            // Remove Button
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    wishlistManager.removeFromWishlist(coin.id ?? "")
                }
            }) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: shadowColor, radius: 4, x: 0, y: 2)
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
    }
    
    private var imageBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
    }
    
    private var primaryTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var secondaryTextColor: Color {
        colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray)
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.08)
    }
}