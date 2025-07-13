//
//  MainTabView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainTabView: View {
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var wishlistManager = WishlistManager.shared
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        TabView {
            // Home Tab
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Wishlist Tab
            WishlistTabView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Wishlist")
                }
                .badge(wishlistManager.wishlistCoinIds.isEmpty ? 0 : wishlistManager.wishlistCoinIds.count)
                .tag(1)
        }
        .environmentObject(themeManager)
        .environmentObject(wishlistManager)
        .preferredColorScheme(themeManager.currentTheme.colorScheme)
        .accentColor(tabAccentColor)
        .onAppear {
            setupTabBarAppearance()
        }
    }
    
    private var tabAccentColor: Color {
        let effectiveScheme = themeManager.currentTheme.colorScheme ?? systemColorScheme
        return effectiveScheme == .dark ? .blue : .blue
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Tab bar background
        let effectiveScheme = themeManager.currentTheme.colorScheme ?? systemColorScheme
        appearance.backgroundColor = effectiveScheme == .dark ? 
            UIColor.systemBackground : UIColor.systemBackground
        
        // Selected item color
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue
        ]
        
        // Unselected item color
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemGray
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
