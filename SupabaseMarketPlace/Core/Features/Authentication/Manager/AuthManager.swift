//
//  AuthManager.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import Foundation

@Observable
final class AuthManager {
    private let authService: SupabaseAuthService
    
    var authState: AuthState = .unknown
    var currentUserId: String?
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
    
    func signIn(email: String, password: String) async {
        do {
            currentUserId = try await authService.signIn(email: email, password: password)
            authState = .authenticated
            print("DEBUG: AuthState: \(authState)")
        } catch {
            print("Error sign in: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String, username: String) async {
        do {
            currentUserId = try await authService.signUp(email: email, password: password, username: username)
            authState = .authenticated
            print("DEBUG: AuthState: \(authState)")
        } catch {
            print("Error sign up: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            currentUserId = nil
            authState = .unauthenticated
            print("DEBUG: AuthState: \(authState)")
        } catch {
            print("Error sign out: \(error.localizedDescription)")
        }
    }
    
    func refeshUser() async {
        do {
            let userSessionId = try await authService.getCurrentUserSession()
            if let userSessionId {
                currentUserId = userSessionId
                authState = .authenticated
            }
        } catch {
            print("Error refesh user: \(error.localizedDescription)")
            currentUserId = nil
            authState = .unauthenticated
        }
    }
}
