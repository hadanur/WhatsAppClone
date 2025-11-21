//
//  RegisterView.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//
import SwiftUI

struct RegisterView: View {
    @Environment(RegisterViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack {
            VStack {
                Image(systemName: "person.fill.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.whatsappGreen)
                    .padding(.top, 50)
                
                Text("Yeni Hesap Oluştur")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                VStack(spacing: 20) {
                    TextField("Kullanıcı Adı", text: $viewModel.username)
                        .padding()
                        .background(Color(.systemGray6))
                        .autocapitalization(.none)
                        .cornerRadius(10)
                    
                    TextField("E-posta Adresi", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Şifre (En az 6 karakter)", text: $viewModel.password)
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
                    Task { await viewModel.signUp() }
                } label: {
                    Text("Kayıt Ol")
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
                    Text("Zaten hesabın var mı?")
                    
                    Button {
                        viewModel.goBackToLogin()
                    } label: {
                        Text("Giriş Yap")
                            .fontWeight(.bold)
                            .foregroundColor(.whatsappGreen)
                    }
                }
                .padding(.vertical, 20)
                
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
                    
                    Text("Hesap Oluşturuluyor...")
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
        .navigationTitle("Kayıt Ol")
        .navigationBarTitleDisplayMode(.inline)
    }
}
