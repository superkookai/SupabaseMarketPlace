//
//  UserManager.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 10/12/2568.
//

import Foundation

@Observable
final class UserManager {
    var currentUser: User?
    var isLoading = false
    
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
    }
    
    func fetchCurrentUser() async {
        isLoading = true
        defer { isLoading = false }
        do {
            currentUser = try await service.fetchCurrentUser()
            print("DEBUG: current user: \(currentUser?.username ?? "NONE")")
        } catch {
            print("Error laoding current user: \(error.localizedDescription)")
        }
    }
}
