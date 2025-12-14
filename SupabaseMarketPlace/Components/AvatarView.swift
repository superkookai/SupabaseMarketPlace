//
//  AvatarView.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 14/12/2568.
//

import SwiftUI
import Kingfisher

struct AvatarView: View {
    private let imageUrl: String?
    private let size: AvatarSize
    private let profileImage: Image?
    private let onTap: (() -> Void)?
    
    init(imageUrl: String?, size: AvatarSize, profileImage: Image?, onTap: (() -> Void)?) {
        self.imageUrl = imageUrl
        self.size = size
        self.profileImage = profileImage
        self.onTap = onTap
    }
    
    var body: some View {
        Group {
            if let profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
            } else if let imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
                    .foregroundStyle(Color(.systemGray5))
            }
        }
        .onTapGesture {
            if let onTap { onTap() }
        }
    }
}

#Preview {
    AvatarView(imageUrl: nil, size: .medium, profileImage: nil, onTap: nil)
}
