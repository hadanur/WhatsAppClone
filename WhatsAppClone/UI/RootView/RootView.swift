//
//  RootView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

struct RootView: View {

    @ObservedObject var router: AppRouter
    @StateObject var authVM: AuthViewModel
    @StateObject var registerVM: RegisterViewModel

    init(router: AppRouter) {
        self.router = router
        _authVM = StateObject(wrappedValue: AuthViewModel(router: router))
        _registerVM = StateObject(wrappedValue: RegisterViewModel(router: router))
    }

    var body: some View {
        switch router.screen {
        case .loading:
            ProgressView()
        case .auth:
            AuthView()
                .environmentObject(authVM)
                .environmentObject(router)
        case .register:
            RegisterView()
                .environmentObject(registerVM)
                .environmentObject(router)
        case .main:
            ChatsView()
                .environmentObject(router)
        }
    }
}
