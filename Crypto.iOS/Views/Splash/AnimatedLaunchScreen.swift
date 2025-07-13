// AnimatedLaunchScreen.swift
import SwiftUI

struct AnimatedLaunchScreen: View {
    @State private var isLoading = true
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var backgroundGradient = false
    
    var body: some View {
        if !isLoading {
            MainTabView()
        } else {
            ZStack {
                // Animated Background
                LinearGradient(
                    colors: backgroundGradient ? 
                        [Color.blue.opacity(0.8), Color.purple.opacity(0.8)] :
                        [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: backgroundGradient)
                
                VStack(spacing: 30) {
                    // Logo
                    Image("splash-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // App Name
                    Text("Crypto.iOS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(textOpacity)
                    
                    // Loading Indicator
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .opacity(textOpacity)
                }
            }
            .onAppear {
                startAnimations()
            }
        }
    }
    
    private func startAnimations() {
        // Background animation
        backgroundGradient = true
        
        // Logo animation
        withAnimation(.spring(response: 1.0, dampingFraction: 0.6)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        
        // Text animation (delayed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeIn(duration: 0.8)) {
                textOpacity = 1.0
            }
        }
        
        // Navigate to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                isLoading = false
            }
        }
    }
}