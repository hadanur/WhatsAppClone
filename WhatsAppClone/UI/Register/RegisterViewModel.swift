//
//  RegisterViewModel.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Observation

@Observable
final class RegisterViewModel {

    var email = ""
    var password = ""
    var username = ""
    
    var isLoading = false
    var errorMessage: String?
    
    private let collection = Firestore.firestore().collection("users")
    
    @MainActor
    func signUp() {
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            self.errorMessage = "Lütfen tüm alanları doldurun."
            return
        }

        guard password.count >= 6 else {
            self.errorMessage = "Şifreniz en az 6 karakter olmalıdır."
            return
        }

        self.isLoading = true
        self.errorMessage = nil

        Task {
            defer { self.isLoading = false }
            
            do {
                try await checkUsernameUnique(username: username)
                
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                let user = result.user

                try await saveUserToFirestore(user: user, email: email, username: username)
                                
            } catch {
                print("DEBUG: Kayıt Hatası: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
        }
    }
        
    // MARK: - Firestore Yardımcı Fonksiyonları
    
    private func saveUserToFirestore(user: FirebaseAuth.User, email: String, username: String) async throws {
        let userData: [String: Any] = [
            "uid": user.uid,
            "email": email,
            "username": username,
            "profileImageUrl": "",
            "dateCreated": Timestamp()
        ]
                
        try await collection.document(user.uid).setData(userData)
    }
    
    private func checkUsernameUnique(username: String) async throws {
        let snapshot = try await collection
            .whereField("username", isEqualTo: username)
            .getDocuments()
        
        if !snapshot.isEmpty {
            throw NSError(domain: "Register", code: 409, userInfo: [NSLocalizedDescriptionKey: "Bu kullanıcı adı zaten kullanımda. Lütfen başka bir tane seçin."])
        }
    }
}
