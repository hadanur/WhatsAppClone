//
//  ChatsView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

struct ChatsView: View {
    @State private var viewModel: ChatsViewModel
    private var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
        _viewModel = State(initialValue: ChatsViewModel())
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack {
            VStack {
                Image(systemName: "message.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color.whatsappGreen)
                    .padding()
                
                Text("Sohbet Listeniz Burada Olacak")
                    .font(.title2)
                    .foregroundStyle(.gray)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.top)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Sohbetler")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Çıkış Yap") {
                        Task { await viewModel.signOut() }
                    }
                    .tint(.red)
                    .disabled(viewModel.isLoading)
                }
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .disabled(viewModel.isLoading)
            
            
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ProgressView()
                        .controlSize(.large)
                        .tint(.white)
                    
                    Text("Çıkış Yapılıyor...")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 35)
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
    }
}
