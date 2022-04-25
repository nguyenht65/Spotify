//
//  UserProfile.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

// MARK: - UserProfile
struct UserProfile: Codable {
    let country, displayName, email: String
    let explicitContent: ExplicitContent
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let id: String
    let images: [Image]
    let product: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        //        case followers
        case id
        case images
        case product
    }
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterEnabled, filterLocked: Bool
    
    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

//// MARK: - Followers
//struct Followers: Codable {
//    let href: String?
//    let total: Int?
//}
