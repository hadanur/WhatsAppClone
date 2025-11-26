//
//  AuthManager.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 21/11/2025.
//

import Foundation
import FirebaseAuth

@Observable
final class AuthManager {
    
    static let shared = AuthManager()
    
    var appStatus: AppStatus = .undefined
    
    var userSession: FirebaseAuth.User?
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    private init() {
        setupListener()
    }
    
    private func setupListener() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
            
            if user != nil {
                self?.appStatus = .authenticated
            } else {
                self?.appStatus = .unauthenticated
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
    deinit {
        if let listener = listener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
}
