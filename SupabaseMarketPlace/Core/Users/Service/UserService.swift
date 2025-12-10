//
//  UserService.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 10/12/2568.
//

import Foundation
import Supabase

struct UserService {
    private let client: SupabaseClient
    
    init() {
        client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectUrlString)!, supabaseKey: Constants.projectAPIKey)
    }
    
    func fetchCurrentUser() async throws -> User {
        let supabaseUser = try await client.auth.session.user
        return try await client.from("users")
            .select()
            .eq("id", value: supabaseUser.id.uuidString)
            .single()
            .execute()
            .value
    }
}
