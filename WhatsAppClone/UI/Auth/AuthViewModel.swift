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
import Combine

final class AuthViewModel: ObservableObject {
    private var router: AppRouter

    @Published var email = ""
    @Published var password = ""
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var auth = Auth.auth()
    
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

            router.goToMain()
        } catch {
            print("DEBUG: Giriş Hatası: \(error.localizedDescription)")
            self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
        }

        self.isLoading = false
    }
    
    func goToRegister() {
        router.goToRegister()
    }
}
