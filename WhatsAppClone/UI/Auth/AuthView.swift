//
//  AuthView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 19/11/2025.
//

import SwiftUI

struct AuthView: View {
    @Environment(AuthViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationView {
            VStack {
                
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.whatsappGreen)
                    .padding(.top, 100)
                
                Text("Hoş Geldiniz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                VStack(spacing: 20) {
                    
                    TextField("E-posta Adresi", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Şifre", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if let error = viewModel.errorMessage {
                                   Text(error)
                                       .foregroundColor(.red)
                                       .font(.footnote)
                                       .padding(.top, 5)
                                       .padding(.horizontal)
                                       .multilineTextAlignment(.center)
                               }
                
                Button {
                    Task { await viewModel.signIn() }
                } label: {
                    Text("Giriş Yap")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.whatsappGreen)
                        .cornerRadius(10)
                        .padding(.top, 25)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Divider()
                
                HStack {
                    Text("Hesabın yok mu?")
                    
                    Button {
                        viewModel.goToRegister()
                    } label: {
                        Text("Kayıt Ol")
                            .fontWeight(.bold)
                            .foregroundColor(.whatsappGreen)
                    }
                }
                .padding(.vertical, 20)
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    AuthView()
}
