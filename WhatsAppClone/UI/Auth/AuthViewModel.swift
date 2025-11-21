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
    private var router: AppRouter

    var email = ""
    var password = ""
    
    var userSession: FirebaseAuth.User?
    var isLoading = false
    var errorMessage: String?
    
    private let auth = Auth.auth()
    
    init(router: AppRouter) {
        self.router = router
        self.userSession = auth.currentUser
    }
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            self.errorMessage = "Lütfen e-posta ve şifrenizi girin."
            return
        }

        self.isLoading = true
        self.errorMessage = nil

        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            self.userSession = result.user

        } catch {
            print("DEBUG: Giriş Hatası: \(error.localizedDescription)")
            self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
        }

        self.isLoading = false
    }
    
    func goToRegister() {
        router.push(.register)
    }
}
