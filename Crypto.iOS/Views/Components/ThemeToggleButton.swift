struct ThemeToggleButton: View {
    @ObservedObject var themeManager: ThemeManager
    @State private var showingThemeSelector = false
    @State private var isAnimating = false
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isAnimating = true
                showingThemeSelector = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isAnimating = false
            }
        }) {
            Image(systemName: themeManager.currentTheme.iconName)
                .font(.title3)
                .foregroundColor(buttonColor)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .rotationEffect(.degrees(isAnimating ? 180 : 0))
        }
        .confirmationDialog("Choose Theme", isPresented: $showingThemeSelector, titleVisibility: .visible) {
            ForEach(ThemeManager.AppTheme.allCases, id: \.self) { theme in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        themeManager.setTheme(theme)
                    }
                }) {
                    HStack {
                        Image(systemName: theme.iconName)
                        Text(theme.displayName)
                        if themeManager.currentTheme == theme {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
    }
    
    private var buttonColor: Color {
        let currentScheme = themeManager.currentTheme.colorScheme ?? systemColorScheme
        switch themeManager.currentTheme {
        case .light:
            return .orange
        case .dark:
            return .blue
        case .system:
            return currentScheme == .dark ? .purple : .green
        }
    }
}
