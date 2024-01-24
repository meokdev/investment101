//
//  SwiftUIView.swift
//  investment 101
//
//  Created by ian cheng on 1/23/24.
//

import SwiftUI

struct redirectview: View {
    var body: some View {
        List {
            VStack{
                NavigationLink(destination: stock_loading()) {
                    HStack {
                        Image("stockicon") // Replace with your image
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 120, height: 120)
                        
                        VStack(alignment: .leading) {
                            Text("Stock View")
                                .font(.headline) // Style for primary text
                            Text("View current stock trends") // Additional description
                                .font(.subheadline) // Style for secondary text
                        }
                        .padding(.leading, 8)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
struct stock_loading: View {
    
    @State var showSplash: Bool = false
    
    var body: some View {
        ZStack {
            if self.showSplash {
                MainListView()
            } else {
                SplashScreenView()
                    
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                withAnimation {
                    self.showSplash = true
                }
            }
        }
    }
}




#Preview {
    redirectview()
}
