//
//  SplashScreenView.swift
//  investment 101
//
//  Created by Celine Tsai on 19/1/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        Image("SplashScreen")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all) // This ensures the image covers the safe area
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
