//
//  ThemeToggleButton.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct ThemeToggleButton: View {
    @ObservedObject var themeManager: ThemeManager
    @State private var isPressed = false
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                themeManager.toggleTheme()
            }
        }) {
            ZStack {
                // Background track
                Capsule()
                    .fill(trackColor)
                    .frame(width: 52, height: 28)
                
                // Sliding indicator
                HStack {
                    if isLightMode {
                        Spacer()
                    }
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                        .overlay(
                            Image(systemName: currentModeIcon)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(iconColor)
                        )
                    
                    if !isLightMode {
                        Spacer()
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
    
    private var isLightMode: Bool {
        let effectiveScheme = themeManager.currentTheme.colorScheme ?? systemColorScheme
        return effectiveScheme == .light
    }
    
    private var trackColor: Color {
        isLightMode ? Color.orange.opacity(0.3) : Color.blue.opacity(0.3)
    }
    
    private var currentModeIcon: String {
        isLightMode ? "sun.max.fill" : "moon.fill"
    }
    
    private var iconColor: Color {
        isLightMode ? .orange : .blue
    }
}
