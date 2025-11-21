//
//  ChatsView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

struct ChatsView: View {
    @State private var viewModel = ChatsViewModel()
    @Environment(AppRouter.self) var router

    var body: some View {
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
        .navigationTitle("Sohbetler")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Çıkış Yap") {
                    viewModel.signOut()
                }
                .tint(.red)
            }
        }
    }
}
