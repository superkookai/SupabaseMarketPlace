//
//  SupabaseAuthService.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import Foundation
import Supabase

struct SupabaseAuthService {
    private let client: SupabaseClient
    
    init() {
        client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectUrlString)!, supabaseKey: Constants.projectAPIKey)
    }
    
    func signUp(email: String, password: String, username: String) async throws -> String {
        let response = try await client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        
        try await uploadUserData(with: userId, email: email, username: username)
        
        return userId
    }
    
    func signIn(email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUserSession() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
    
    private func uploadUserData(with uid: String, email: String, username: String) async throws {
        let user = User(id: uid, email: email, username: username, createdAt: .now, profileImageUrl: nil, totalSales: 0, itemsSold: 0, itemsPurchased: 0)
        try await client.from("users").insert(user).execute()
    }
}
