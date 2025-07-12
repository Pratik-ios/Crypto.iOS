//
//  ErrorToastView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct ErrorToastView: View {
    let message: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                    .font(.title3)
                
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : Color(.systemBackground)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.4) : Color.black.opacity(0.2)
    }
}
