//
//  View.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//
import SwiftUI

extension View {
    func adaptiveCardStyle(colorScheme: ColorScheme) -> some View {
        self
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(cardBackground(colorScheme))
            .overlay(cardBorder(colorScheme))
            .shadow(color: cardShadowColor(colorScheme), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
    }
    
    func listRowModifiers() -> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    
    private func cardBackground(_ colorScheme: ColorScheme) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
    }
    
    private func cardBorder(_ colorScheme: ColorScheme) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(
                colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6),
                lineWidth: 0.5
            )
    }
    
    private func cardShadowColor(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color.black.opacity(0.4)
            : Color.black.opacity(0.1)
    }
    
    func errorOverlay(_ errorMessage: String?) -> some View {
        self.overlay(alignment: .center) {
            if let error = errorMessage {
                ErrorToastView(message: error)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: errorMessage)
            }
        }
    }
    
}
