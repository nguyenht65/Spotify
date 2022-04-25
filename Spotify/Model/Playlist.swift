//
//  Playlist.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

struct Playlist: Codable {
    let collaborative: Bool
    let playlistDescription: String
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    //    let playlistPublic: Bool
    let snapshotID: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case playlistDescription = "description"
        case externalUrls = "external_urls"
        case id, images, name, owner
        //        case playlistPublic = "public"
        case snapshotID = "snapshot_id"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let id: String
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id
        case displayName = "display_name"
    }
}
