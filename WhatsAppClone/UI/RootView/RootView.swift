//
//  RootView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

struct RootView: View {
    @Bindable var router: AppRouter

    var body: some View {
        
        switch AuthManager.shared.appStatus {
            
        case .undefined:
            ZStack {
                Color.white.ignoresSafeArea()
                ProgressView()
                    .controlSize(.large)
            }
            
        case .unauthenticated:
            NavigationStack(path: $router.path) {
                
                AuthView(viewModel: AuthViewModel())
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .register:
                            RegisterView(viewModel: RegisterViewModel())
                        default:
                            EmptyView()
                        }
                    }
            }
            
        case .authenticated:
            NavigationStack(path: $router.path) {
                ChatsView(viewModel: ChatsViewModel())
            }
        }
    }
}
