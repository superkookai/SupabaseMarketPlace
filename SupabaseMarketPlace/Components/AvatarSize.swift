//
//  AvatarSize.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 14/12/2568.
//

import Foundation

enum AvatarSize {
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xSmall: 40
        case .small: 48
        case .medium: 60
        case .large: 80
        case .xLarge: 96
        }
    }
}
