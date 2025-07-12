//
//  LinkCard.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct LinkCard: View {
    let title: String
    let icon: String
    let url: URL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Link(destination: url) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
                
                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 6, x: 0, y: 3)
            )
        }
    }
}
