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
            switch authManager.status {
                
            case .loading:
                ProgressView()
                    .controlSize(.large)
                
            case .unauthenticated:
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
        .onChange(of: authManager.status) { _, _ in
            router.path = []
        }
    }
}
