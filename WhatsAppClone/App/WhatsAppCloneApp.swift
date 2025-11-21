//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 19/11/2025.
//

import SwiftUI
import FirebaseCore

@main
struct WhatsAppCloneApp: App {

    @State private var authManager: AuthManager
    @State private var router: AppRouter

    init() {
        FirebaseApp.configure()
        
        _authManager = State(initialValue: AuthManager())
        _router = State(initialValue: AppRouter())
    }

    var body: some Scene {
        WindowGroup {
            RootView(authManager: authManager, router: router)
        }
    }
}
