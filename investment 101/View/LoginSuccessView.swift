//
//  StartView.swift
//  investment 101
//
//  Created by Celine Tsai on 19/1/24.
//

import SwiftUI

struct LoginSuccessView: View {
    
    @State var showSplash: Bool = false
    
    var body: some View {
        ZStack {
            if showSplash {
                MainMenuView()
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.showSplash = true
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
        .navigationBarHidden(true) // Optionally hide the entire navigation bar
    }
}


struct LoginSuccessView_preview: PreviewProvider {
    static var previews: some View {
        LoginSuccessView()
    }
}
