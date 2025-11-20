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

    @StateObject var router = AppRouter()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView(router: router)
        }
    }
}
