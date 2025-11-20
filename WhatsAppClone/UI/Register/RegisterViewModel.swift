//
//  RegisterViewModel.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import Combine

final class RegisterViewModel: ObservableObject {
    private var router: AppRouter

    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var auth = Auth.auth()
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func signUp() async {
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

        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let user = result.user

            try await saveUserToFirestore(user: user, email: email, username: username)

            self.userSession = user
            self.isLoading = false
            
            goToAuth()
        } catch {
            print("DEBUG: Kayıt Hatası: \(error.localizedDescription)")
            self.errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    func goToAuth() {
        router.goToAuth()
    }
        
    // MARK: - Firestore Yardımcı Fonksiyonu
    private func saveUserToFirestore(user: FirebaseAuth.User, email: String, username: String) async throws {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "uid": user.uid,
            "email": email,
            "username": username,
            "profileImageUrl": "",
        ]
        
        try await db.collection("users").document(user.uid).setData(userData)
    }
}
