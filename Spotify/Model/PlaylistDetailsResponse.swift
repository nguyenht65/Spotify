//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by NguyenHT on 25/04/2022.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let collaborative: Bool
    let playlistDescription: String
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let playlistPublic: Bool
    let snapshotID: String
    let tracks: PlaylistTracksResponse
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case playlistDescription = "description"
        case externalUrls = "external_urls"
        case id, images, name, owner
        case playlistPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks
    }
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: Track
}
