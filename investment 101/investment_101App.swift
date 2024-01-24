//
//  investment_101App.swift
//  investment 101
//
//  Created by Celine Tsai on 14/12/23.
//

import SwiftUI

@main
struct investment_101App: App {
    let persistenceController = PersistenceController.shared

    @StateObject var appVM = AppViewModel()
    @StateObject var globalVar = Globalvar()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                StartView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .environmentObject(appVM)
        }
    }
}




