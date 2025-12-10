//
//  SupabaseMarketPlaceApp.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import SwiftUI

@main
struct SupabaseMarketPlaceApp: App {
    @State private var authManager = AuthManager()
    @State private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
                .environment(userManager)
        }
    }
}
