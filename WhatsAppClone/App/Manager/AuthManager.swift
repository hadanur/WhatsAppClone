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
    
    var userSession: FirebaseAuth.User?
    var isLoading = true
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    init() {
        setupListener()
    }
    
    private func setupListener() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
            self?.isLoading = false
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
