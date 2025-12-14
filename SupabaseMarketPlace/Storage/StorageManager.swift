//
//  StorageManager.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 14/12/2568.
//

import Foundation
import Supabase

struct StorageManager {
    private let client: SupabaseClient
    
    init() {
        client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectUrlString)!, supabaseKey: Constants.projectAPIKey)
    }
    
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String {
        let path = "\(user.id)/avatar.jpg"
        let fullPath = try await client.storage
            .from("avatars")
            .update(path, data: imageData)
            .path
        
        print("DEBUG: Profile Photo full path: \(fullPath)")
        
        let publicUrl = "\(Constants.projectUrlString)/storage/v1/object/public/avatars/\(path)"
        
        return publicUrl
    }
    
    //TODO: Upload Listing Photos
}
