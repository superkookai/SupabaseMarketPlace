//
//  UserProfileView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 10/12/2568.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var currentUser: User {
        userManager.currentUser ?? User.mock
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 72, height: 72)
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading) {
                            Text(currentUser.username.capitalized)
                            
                            Text(currentUser.email)
                                .foregroundStyle(.secondary)
                        }
                        .font(.subheadline)
                    }
                }
                
                Section("Account") {
                    Button {
                        Task {
                            await authManager.signOut()
                        }
                    } label: {
                        Text("Sign Out")
                            .foregroundStyle(.red)
                    }
                
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
