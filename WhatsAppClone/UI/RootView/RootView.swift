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

    init(authManager: AuthManager, router: AppRouter) {
        self.authManager = authManager
        self.router = router
    }

    var body: some View {
        @Bindable var router = router
        
        ZStack {
            if authManager.isLoading {
                ProgressView()
                    .controlSize(.large)
                
            } else if authManager.userSession == nil {
                NavigationStack(path: $router.path) {
                    AuthView(router: router)
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .register:
                                RegisterView(router: router)
                            default:
                                EmptyView()
                            }
                        }
                }
                
            } else {
                NavigationStack(path: $router.path) {
                    ChatsView(router: router)
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            default:
                                EmptyView()
                            }
                        }
                }
            }
        }
        .onChange(of: authManager.userSession) { _, _ in
            router.path = []
        }
    }
}
