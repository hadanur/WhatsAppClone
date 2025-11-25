//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 19/11/2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    var authManager: AuthManager?
    var router: AppRouter?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        self.authManager = AuthManager()
        self.router = AppRouter()
        
        return true
    }
}

@main
struct WhatsAppCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if let authManager = delegate.authManager,
               let router = delegate.router {
                
                RootView(authManager: authManager, router: router)
                
            } else {
                ProgressView()
            }
        }
    }
}
