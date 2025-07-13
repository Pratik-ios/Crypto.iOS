//
//  ThemeManager.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: AppTheme = .system
    @Published var userSelectedTheme: UserTheme = .none // Tracks user's manual choice
    
    enum AppTheme: String, CaseIterable {
        case system = "system"
        case light = "light"
        case dark = "dark"
        
        var colorScheme: ColorScheme? {
            switch self {
            case .system: return nil
            case .light: return .light
            case .dark: return .dark
            }
        }
    }
    
    enum UserTheme: String, CaseIterable {
        case none = "none"      // Follows system (default)
        case light = "light"    // User chose light
        case dark = "dark"      // User chose dark
        
        var displayName: String {
            switch self {
            case .none: return "Auto"
            case .light: return "Light"
            case .dark: return "Dark"
            }
        }
        
        var iconName: String {
            switch self {
            case .none: return "circle.lefthalf.filled"
            case .light: return "sun.max.fill"
            case .dark: return "moon.fill"
            }
        }
        
        var appTheme: AppTheme {
            switch self {
            case .none: return .system
            case .light: return .light
            case .dark: return .dark
            }
        }
    }
    
    // Only show Light/Dark options (no auto)
    static let availableThemes: [UserTheme] = [.light, .dark]
    
    init() {
        loadTheme()
        updateCurrentTheme()
    }
    
    func setTheme(_ theme: UserTheme) {
        userSelectedTheme = theme
        updateCurrentTheme()
        saveTheme()
    }
    
    func toggleTheme() {
        switch userSelectedTheme {
        case .none, .light:
            setTheme(.dark)
        case .dark:
            setTheme(.light)
        }
    }
    
    private func updateCurrentTheme() {
        currentTheme = userSelectedTheme.appTheme
    }
    
    private func saveTheme() {
        UserDefaults.standard.set(userSelectedTheme.rawValue, forKey: "selectedTheme")
    }
    
    private func loadTheme() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = UserTheme(rawValue: savedTheme) {
            userSelectedTheme = theme
        } else {
            // Default: follow system theme
            userSelectedTheme = .none
        }
    }
}
