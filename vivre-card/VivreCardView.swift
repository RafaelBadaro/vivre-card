//
//  VivreCardView.swift
//  vivre-card
//
//  Created by Rafael Badaró on 18/11/24.
//

import SwiftUI

struct VivreCardView: View {
    @StateObject private var compassManager: CompassManager
    
    init(targetLatitude: Double, targetLongitude: Double) {
        _compassManager = StateObject(wrappedValue: CompassManager(targetLatitude: targetLatitude, targetLongitude: targetLongitude))
    }
    
    @State private var isAnimating = false
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    @State private var showCompass = false
    @State private var showCompassText = "Show info"
    
    var body: some View {
        VStack {
            if let _ = compassManager.currentLocation {
                Rectangle()
                    .fill(Color.brown.opacity(0.8))
                    .frame(width: 300, height: 300)
                    .cornerRadius(2)
                    .shadow(color: .black, radius: 0.1, x: 1, y: 1)
                    .offset(x: offsetX, y: offsetY)
                    .onAppear {
                        startAnimation()
                    }
                
                if showCompass {
                    VStack {
                        // Rotate the arrow based on the bearing angle towards the target location
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle(degrees: compassManager.rotationAngle))  // Rotate based on bearing
                            .foregroundColor(.blue)
                        
                        Text("Magnetic Heading: \(compassManager.heading?.magneticHeading ?? 0.0, specifier: "%.1f")°")
                            .font(.title2)
                        Text("Angle to Target: \(compassManager.rotationAngle, specifier: "%.1f")°")
                            .font(.title2)
                    }.padding(.top, 50)
                }
            
            } else {
                Text("Fetching location...")
            }
        }
        .toolbar {
            ToolbarItem {
                Button(showCompassText) {
                    if showCompassText == "Show info" {
                        showCompassText = "Hide info"
                    } else {
                        showCompassText = "Show info"
                    }
                    showCompass.toggle()
                }
            }
        }
    }
    
    private func startAnimation() {
        isAnimating = true
        withAnimation(.easeInOut(duration: 1)) {
            offsetX = CGFloat(compassManager.xAxisDirection)
            offsetY = CGFloat(compassManager.yAxisDirection)
        }
        
        // Reverse animation after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 1)) {
                offsetX = 0
                offsetY = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isAnimating = false
                startAnimation() // Restart the animation
            }
        }
    }
}

#Preview {
    VivreCardView(targetLatitude: 37.7749,
                  targetLongitude: -122.4194)
}
