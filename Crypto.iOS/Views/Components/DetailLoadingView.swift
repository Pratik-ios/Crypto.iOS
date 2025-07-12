//
//  DetailLoadingView.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

extension DetailView {
    var coinSymbolView: some View {
        HStack(spacing: 8) {
            Text((viewModel.coin.symbol ?? "").uppercased())
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(secondaryTextColor)
            
            WebImage(url: viewModel.coin.image)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
    }
    
    var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground)
    }
    
    var cardBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground)
    }
    
    var primaryTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var secondaryTextColor: Color {
        colorScheme == .dark ? .gray : Color(.systemGray)
    }
    
    var shadowColor: Color {
        colorScheme == .dark ? .black.opacity(0.3) : .black.opacity(0.1)
    }
    
    var gridColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    }
}

// MARK: - Loading State View
struct DetailLoadingView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            // Animated coin icon
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(.degrees(loadingRotation))
            }
            
            Text("Loading coin details...")
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground))
    }
    
    @State private var loadingRotation: Double = 0
    
    private var loadingAnimation: Animation {
        Animation.linear(duration: 1.0).repeatForever(autoreverses: false)
    }
    
    init() {
        
            withAnimation(self.loadingAnimation) {
                self.loadingRotation = 360
            }
        
    }
}

// MARK: - Error State View
struct DetailErrorView: View {
    let error: String
    let retry: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            
            Text("Failed to load details")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Text(error)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .gray : Color(.systemGray))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: retry) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color(.systemBackground) : Color(.systemGroupedBackground))
        .padding()
    }
}
