//
//  LoginView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthManager.self) private var authManager
    
    @Namespace var namespace
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.supabaseNB)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.regularMaterial,in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.regularMaterial,in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                
                }
                .padding(.bottom)
                
                Button {
                    signIn()
                } label: {
                    Text("Login")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.tint,in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)

                Spacer()
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                        .navigationTransition(.zoom(sourceID: "zoom", in: namespace))
                } label: {
                    HStack {
                        Text("Don't have account?")
                        
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .matchedTransitionSource(id: "zoom", in: namespace)
                }
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}

private extension LoginView {
    private func signIn() {
        Task {
            isLoading = true
            await authManager.signIn(email: email, password: password)
            isLoading = false
        }
    }
    
    var formIsValid: Bool {
        email.isValidEmail() && !password.isEmpty
    }
}

#Preview {
    LoginView()
        .environment(AuthManager())
}
