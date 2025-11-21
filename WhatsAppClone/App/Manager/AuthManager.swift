//
//  AuthManager.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 21/11/2025.
//

import Foundation
import FirebaseAuth
import Observation

@Observable
final class AuthManager {
    
    var status: AppStatus = .loading
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    init() {
        setupListener()
    }
    
    private func setupListener() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            if user != nil {
                self.status = .authenticated
            } else {
                self.status = .unauthenticated
            }
        }
    }
    
    deinit {
        if let listener = listener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
}
