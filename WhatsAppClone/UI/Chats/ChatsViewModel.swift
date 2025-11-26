//
//  ChatsViewModel.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 21/11/2025.
//


import Foundation
import FirebaseAuth

@Observable
final class ChatsViewModel {
    
    var isLoading = false
    var errorMessage: String?
    

    @MainActor
    func signOut() {
        self.isLoading = true
        
        defer {
            self.isLoading = false
        }
        
        AuthManager.shared.signOut()
    }
}
