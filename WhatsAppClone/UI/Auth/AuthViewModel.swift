//
//  AuthViewModel.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Observation

@Observable
final class AuthViewModel {

    var emailOrUsername = ""
    var password = ""
    
    var isLoading = false
    var errorMessage: String?

    @MainActor
    func signIn() {
        if isLoading { return }

        guard !emailOrUsername.isEmpty, !password.isEmpty else {
            self.errorMessage = "Lütfen kullanıcı bilgilerinizi girin."
            return
        }

        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            defer {
                self.isLoading = false
            }

            do {
                let email = try await resolveEmail(from: emailOrUsername)
                
                try await Auth.auth().signIn(withEmail: email, password: password)
                                
            } catch {
                print("DEBUG: Giriş Hatası: \(error.localizedDescription)")
                self.errorMessage = "Giriş başarısız: Bilgilerinizi kontrol edin."
            }
        }
    }
    
    // MARK: - Yardımcı Fonksiyon (Username -> Email Çevirici)
    
    private func resolveEmail(from input: String) async throws -> String {
        // A. Eğer input "@" içeriyorsa zaten email'dir, olduğu gibi döndür.
        if input.contains("@") {
            return input
        }
                
        let collection = Firestore.firestore().collection("users")
        
        let snapshot = try await collection
            .whereField("username", isEqualTo: input)
            .getDocuments()
        
        // Eğer doküman bulunduysa email'i al
        if let document = snapshot.documents.first,
           let email = document.data()["email"] as? String {
            return email
        } else {
            // Username veritabanında yoksa hata fırlat
            throw NSError(domain: "Auth", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bu kullanıcı adı bulunamadı."])
        }
    }
}
