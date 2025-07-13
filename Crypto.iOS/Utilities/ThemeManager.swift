class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .system
    
    enum AppTheme: String, CaseIterable {
        case system = "system"
        case light = "light"
        case dark = "dark"
        
        var displayName: String {
            switch self {
            case .system: return "Auto"
            case .light: return "Light"
            case .dark: return "Dark"
            }
        }
        
        var iconName: String {
            switch self {
            case .system: return "circle.lefthalf.filled"
            case .light: return "sun.max.fill"
            case .dark: return "moon.fill"
            }
        }
        
        var colorScheme: ColorScheme? {
            switch self {
            case .system: return nil
            case .light: return .light
            case .dark: return .dark
            }
        }
    }
    
    init() {
        loadTheme()
    }
    
    func setTheme(_ theme: AppTheme) {
        currentTheme = theme
        saveTheme()
    }
    
    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: "selectedTheme")
    }
    
    private func loadTheme() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = AppTheme(rawValue: savedTheme) {
            currentTheme = theme
        }
    }
}