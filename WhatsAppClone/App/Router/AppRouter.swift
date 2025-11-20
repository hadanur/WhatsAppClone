//
//  AppRouter.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI
import FirebaseAuth
import Combine

final class AppRouter: ObservableObject {
    
    @Published var screen: AppScreen = .loading
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    init() {
        observeAuth()
    }
    
    private func observeAuth() {
        listener = Auth.auth().addStateDidChangeListener { _, user in
            withAnimation {
                if user == nil {
                    self.screen = .auth
                } else {
                    self.screen = .auth
                }
            }
        }
    }
    
    func goToRegister() {
        screen = .register
    }
    
    func goToAuth() {
        screen = .auth
    }
    
    func goToMain() {
        screen = .main
    }
}
