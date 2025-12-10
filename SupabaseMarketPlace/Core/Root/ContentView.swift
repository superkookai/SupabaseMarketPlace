//
//  ContentView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                UserProfileView()
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task {
            await authManager.refeshUser()
        }
        .task(id: authManager.authState) {
            guard authManager.authState == .authenticated else { return }
            await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
        .environment(UserManager())
}
