//
//  StatisticCard.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct StatisticCard: View {
    let stat: StatisticModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(stat.title ?? "")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? .gray : Color(.systemGray))
                .textCase(.uppercase)
                .tracking(0.5)
            
            Text(stat.value ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            if let percentageChange = stat.percentageChange {
                HStack(spacing: 4) {
                    Image(systemName: percentageChange >= 0 ? "arrow.up" : "arrow.down")
                        .font(.caption2)
                    
                    Text("\(percentageChange, specifier: "%.2f")%")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(percentageChange >= 0 ? .green : .red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 6, x: 0, y: 3)
        )
    }
}
