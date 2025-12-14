//
//  UserProfileView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 10/12/2568.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var isPresentingImagePicker: Bool = false
    @State private var selectedPhotoPickerItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    
    var currentUser: User {
        userManager.currentUser ?? User.mock
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        AvatarView(imageUrl: currentUser.profileImageUrl, size: .large, profileImage: profileImage) {
                            isPresentingImagePicker = true
                        }
                        
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
        .photosPicker(isPresented: $isPresentingImagePicker, selection: $selectedPhotoPickerItem)
        .task(id: selectedPhotoPickerItem) {
            await onImageSelected()
        }
    }
}

private extension UserProfileView {
    func onImageSelected() async {
        guard let selectedPhotoPickerItem else { return }
        guard let user = userManager.currentUser else { return }
        do {
            guard let data = try await selectedPhotoPickerItem.loadTransferable(type: Data.self),
                    let uiImage = UIImage(data: data),
                  let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
            
            self.profileImage = Image(uiImage: uiImage)
            
            let imageUrl = try await StorageManager().uploadProfilePhoto(for: user, imageData: imageData)
            await userManager.updateProfileImageUrl(imageUrl)
        } catch {
            print("Error Failed to upload image data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
