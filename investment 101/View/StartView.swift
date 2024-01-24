

import SwiftUI

struct StartView: View {
    
    @State var showSplash: Bool = false
    
    var body: some View {
        ZStack {
            if self.showSplash {
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
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
