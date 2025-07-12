//
//  DescriptionCard.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct DescriptionCard: View {
    let description: String
    @Binding var showFullDescription: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(description)
                .lineLimit(showFullDescription ? nil : 3)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .gray : Color(.systemGray))
                .animation(.easeInOut(duration: 0.3), value: showFullDescription)
            
            Button(action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    showFullDescription.toggle()
                }
            }) {
                HStack(spacing: 4) {
                    Text(showFullDescription ? "Show Less" : "Read More")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Image(systemName: showFullDescription ? "chevron.up" : "chevron.down")
                        .font(.caption2)
                }
                .foregroundColor(.blue)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 8, x: 0, y: 4)
        )
    }
}
