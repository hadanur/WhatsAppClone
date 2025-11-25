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
    

    func signOut() async {
        self.isLoading = true
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Çıkış hatası: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
