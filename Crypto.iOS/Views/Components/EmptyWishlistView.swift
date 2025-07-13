struct EmptyWishlistView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            // Animated heart icon
            ZStack {
                Circle()
                    .stroke(Color.red.opacity(0.3), lineWidth: 4)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "heart.slash.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.red.opacity(0.6))
            }
            
            VStack(spacing: 12) {
                Text("No Favorites Yet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(primaryTextColor)
                
                Text("Start building your watchlist by tapping the heart icon on any cryptocurrency")
                    .font(.body)
                    .foregroundColor(secondaryTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            // Call to action
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                    Text("Tap")
                        .fontWeight(.semibold)
                    Text("to add favorites")
                }
                .font(.caption)
                .foregroundColor(secondaryTextColor)
                
                HStack(spacing: 8) {
                    Image(systemName: "bell")
                        .foregroundColor(.blue)
                    Text("Track")
                        .fontWeight(.semibold)
                    Text("price changes")
                }
                .font(.caption)
                .foregroundColor(secondaryTextColor)
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground)
    }
    
    private var primaryTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var secondaryTextColor: Color {
        colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray)
    }
}