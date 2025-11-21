//
//  RootView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

struct RootView: View {
    
    @State var authManager: AuthManager
    @State var router: AppRouter
    
    @State var authVM: AuthViewModel
    @State var registerVM: RegisterViewModel

    init(authManager: AuthManager, router: AppRouter) {
        self.authManager = authManager
        self.router = router
        _authVM = State(initialValue: AuthViewModel(router: router))
        _registerVM = State(initialValue: RegisterViewModel(router: router))
    }

    var body: some View {
        @Bindable var router = router
        
        switch authManager.status {
            
        case .loading:
            ProgressView()
            
        case .unauthenticated:
            NavigationStack(path: $router.path) {
                AuthView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .register:
                            RegisterView()
                                .environment(registerVM)
                                .environment(router)
                        
                        default:
                            EmptyView()
                        }
                    }
            }
            .environment(authVM)
            .environment(router)
            
        case .authenticated:
            NavigationStack(path: $router.path) {
                ChatsView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        default:
                            EmptyView()
                        }
                    }
            }
            .environment(router)
        }
    }
}
