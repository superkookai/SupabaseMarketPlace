//
//  RegistrationView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var passwordMatch = false
    @State private var isLoading = false
    
    var body: some View {
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
                
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.regularMaterial,in: .rect(cornerRadius: 10))
                    .padding(.horizontal)
                
                ZStack(alignment: .trailing) {
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.regularMaterial,in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordMatch ? .green : .red)
                            .padding(.trailing, 30)
                    }
                }
                
                ZStack(alignment: .trailing) {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.regularMaterial,in: .rect(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordMatch ? .green : .red)
                            .padding(.trailing, 30)
                    }
                }
                
            }
            .padding(.bottom)
            
            Button {
                signUp()
            } label: {
                Text("Sign Up")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have account?")
                    
                    Text("Login")
                        .fontWeight(.semibold)
                }
            }
        }
        .onChange(of: confirmPassword) { _, _ in
            passwordMatch = password == confirmPassword
        }
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
        
    }
}

private extension RegistrationView {
    private func signUp() {
        Task {
            isLoading = true
            await authManager.signUp(email: email, password: password, username: username)
            isLoading = false
        }
    }
    
    var formIsValid: Bool {
        email.isValidEmail() && passwordMatch && username.count > 1
    }
}

#Preview {
    RegistrationView()
        .environment(AuthManager())
}
