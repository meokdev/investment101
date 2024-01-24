//
//  SplashScreenView.swift
//  investment 101
//
//  Created by Celine Tsai on 19/1/24.
//

import SwiftUI

struct SplashScreenView: View {
    private let quote = "\nThe best investment you can make is in yourself.\n"
    private let author = "- Warren Buffet"
    @State private var displayedText = ""
    @State private var showAuthor = false
    @State private var rotationDegrees = 0.0
    @State private var typingTimer: Timer?
    @State private var loadingProgress = 0.0

    var body: some View {
        VStack(alignment: .center) {
            Image("inapp_icon")
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(rotationDegrees))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                        rotationDegrees = 360
                    }
                }

            Text(displayedText)
                .font(.system(.title3, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

            if showAuthor {
                Text(author)
                    .italic()
                    .transition(.opacity)
            }
            
            // Loading Bar
            ProgressView(value: loadingProgress, total: 1)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.black))
                .scaleEffect(x: 1, y: 2, anchor: .center)
                
                .padding()

        }
        .onAppear {
            startTypingAnimation()
        }
    }

    private func startTypingAnimation() {
        let totalCharacters = quote.count
        var currentIndex = 0

        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if currentIndex < totalCharacters {
                let index = quote.index(quote.startIndex, offsetBy: currentIndex)
                displayedText += String(quote[index])
                currentIndex += 1
                loadingProgress = Double(currentIndex) / Double(totalCharacters)
            } else {
                timer.invalidate()
                showAuthor = true
                loadingProgress = 1
                // Add any actions you want to happen after the typing animation is complete
            }
        }
    }
}



struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
