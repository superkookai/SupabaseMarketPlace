//
//  ContentView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                Text("Main View")
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task {
            await authManager.refeshUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
