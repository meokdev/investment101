//
//  SpalshScreenView.swift
//  investment 101
//
//  Created by Celine Tsai on 19/1/24.
//

import SwiftUI


func convertDictionaryToJson(_ dictionary: [String: Any]?) -> String {
    if let dictionary = dictionary,
       let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
       let jsonString = String(data: jsonData, encoding: .utf8) {
        return jsonString
    }
    return "No user settings found"
}

struct SplashScreenView: View {
    let myBooleanArray: [Bool] = [true,false,false,false,false,false] //for future work
    
    @State private var appSettings: [String: Any]?

    var body: some View {
        Image("SplashScreen")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                
                if UserDefaults.standard.object(forKey: "userprogress") == nil { //change this for testing
                    UserDefaults.standard.set(1, forKey: "userprogress")
                    
                }
                
            }
    }
}



struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

