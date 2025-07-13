//
//  AnimatedLaunchScreen.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 13/07/25.
//

import SwiftUI

struct AnimatedLaunchScreen: View {
    @State private var isLoading = true
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var logoRotation: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var backgroundGradient = false
    @State private var showParticles = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if !isLoading {
            MainTabView()
        } else {
            ZStack {
                // Animated Background
                animatedBackground
                
                
                if showParticles {
                    ParticlesView()
                }
                
                VStack(spacing: 30) {
                    // Crypto Logo with Animation
                    cryptoLogo
                    
                    // App Title
                    appTitle
                    
                    // Loading Indicator
                    loadingIndicator
                }
            }
            .onAppear {
                startAnimations()
            }
        }
    }
}

// MARK: - Animated Components
private extension AnimatedLaunchScreen {
    var animatedBackground: some View {
        LinearGradient(
            colors: backgroundGradient ?
                [Color.blue.opacity(0.9), Color.purple.opacity(0.9), Color.orange.opacity(0.8)] :
                [Color.blue, Color.purple, Color.indigo],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true), value: backgroundGradient)
    }
    
    var cryptoLogo: some View {
        ZStack {
            // Glow Effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.white.opacity(0.3), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 80
                    )
                )
                .frame(width: 160, height: 160)
                .opacity(logoOpacity * 0.7)
            
            // Logo
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.orange, Color.yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .rotationEffect(.degrees(logoRotation))
                .shadow(color: .white.opacity(0.5), radius: 20, x: 0, y: 5)
        }
    }
    
    var appTitle: some View {
        VStack(spacing: 8) {
            Text("Crypto.iOS")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.white, Color.white.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .opacity(textOpacity)
            
            Text("Beautiful Cryptocurrency Tracking")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .opacity(textOpacity)
        }
    }
    
    var loadingIndicator: some View {
        VStack(spacing: 12) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.3)
                .opacity(textOpacity)
            
            Text("Loading market data...")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
                .opacity(textOpacity)
        }
    }
    
    func startAnimations() {
        // Background animation
        withAnimation(.linear(duration: 0.1)) {
            backgroundGradient = true
        }
        
        // Logo scale and opacity animation
        withAnimation(.spring(response: 1.2, dampingFraction: 0.6, blendDuration: 0)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        
        // Logo rotation animation
        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
            logoRotation = 360
        }
        
        // Text animation (delayed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeIn(duration: 0.8)) {
                textOpacity = 1.0
            }
        }
        
        // Particles animation (delayed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeIn(duration: 0.5)) {
                showParticles = true
            }
        }
        
        // Navigate to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                isLoading = false
            }
        }
    }
}

// MARK: - Particles Effect (Optional)
struct ParticlesView: View {
    @State private var particles: [Particle] = []
    
    var body: some View {
        ZStack {
            ForEach(particles, id: \.id) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onAppear {
            createParticles()
            animateParticles()
        }
    }
    
    private func createParticles() {
        particles = (0..<20).map { _ in
            Particle(
                id: UUID(),
                position: CGPoint(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                ),
                color: [Color.white.opacity(0.3), Color.yellow.opacity(0.4), Color.orange.opacity(0.3)].randomElement()!,
                size: CGFloat.random(in: 2...6),
                opacity: Double.random(in: 0.3...0.8)
            )
        }
    }
    
    private func animateParticles() {
        withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: false)) {
            for i in particles.indices {
                particles[i].position.y -= 100
                particles[i].opacity = 0
            }
        }
    }
}

struct Particle {
    let id: UUID
    var position: CGPoint
    let color: Color
    let size: CGFloat
    var opacity: Double
}
