//
//  AuthViewModel.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import Observation

@Observable
final class AuthViewModel {

    var emailOrUsername = ""
    var password = ""
    
    var userSession: FirebaseAuth.User?
    var isLoading = false
    var errorMessage: String?
    
    private let auth = Auth.auth()
    
    init() {
        self.userSession = auth.currentUser
    }
    

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
                let finalEmail = try await resolveEmail(from: emailOrUsername)
                let result = try await auth.signIn(withEmail: finalEmail, password: password)
                self.userSession = result.user
                
            } catch {
                print("DEBUG: Giriş Hatası: \(error.localizedDescription)")
                self.errorMessage = "Giriş başarısız: Kullanıcı adı/şifre yanlış veya internet yok."
            }
        }
    }
    
    // MARK: - Yardımcı Fonksiyon (Username -> Email Çevirici)
    
    private func resolveEmail(from input: String) async throws -> String {
        // A. Eğer input "@" içeriyorsa zaten email'dir, olduğu gibi döndür.
        if input.contains("@") {
            return input
        }
        
        // B. "@" içermiyorsa Username'dir. Firestore'dan bu username'e ait emaili bul.
        let snapshot = try await Firestore.firestore().collection("users")
            .whereField("username", isEqualTo: input) // Username'e göre filtrele
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
