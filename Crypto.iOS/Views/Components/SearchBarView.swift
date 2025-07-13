//
//  SearchBarView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(iconColor)
                .scaleEffect(isSearchFocused ? 1.1 : 1.0)
            
            TextField("Search cryptocurrencies...", text: $searchText)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(textColor)
                .focused($isSearchFocused)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if !searchText.isEmpty {
                Button(action: {
                    withAnimation(.spring()) {
                        searchText = ""
                        isSearchFocused = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(clearButtonColor)
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(glassmorphicBackground)
        .overlay(glassmorphicBorder)
        .shadow(color: shadowColor, radius: 15, x: 0, y: 8)
        .scaleEffect(isSearchFocused ? 1.02 : 1.0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSearchFocused)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private var glassmorphicBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                                Color.white.opacity(colorScheme == .dark ? 0.05 : 0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
    }
    
    private var glassmorphicBorder: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(
                LinearGradient(
                    colors: [
                        Color.white.opacity(colorScheme == .dark ? 0.3 : 0.5),
                        Color.clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: isSearchFocused ? 2 : 1
            )
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var iconColor: Color {
        isSearchFocused ? .blue : (colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray))
    }
    
    private var clearButtonColor: Color {
        colorScheme == .dark ? Color(.systemGray2) : Color(.systemGray)
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.4) : Color.black.opacity(0.15)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
