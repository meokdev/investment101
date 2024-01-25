//
//  investment_101App.swift
//  investment 101
//
//  Created by Celine Tsai on 14/12/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override dark mode for the entire app
        UIWindow.appearance().overrideUserInterfaceStyle = .light
        return true
    }
}

@main
struct investment_101App: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        UserDefaults.standard.register(defaults: ["hasViewedCourseWalkthrough": false])
        UserDefaults.standard.register(defaults: ["hasViewedStockWalkthrough": false])
    }
    
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




