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
    let href, id: String
    let images: [Image]
    let name: String
    let owner: Owner
    //    let playlistPublic: Bool
    let snapshotID: String
    //    let tracks: Tracks
    let type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case playlistDescription = "description"
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        //        case playlistPublic = "public"
        case snapshotID = "snapshot_id"
        case type, uri
        //        case tracks
    }
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let href, id, type, uri: String
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, type, uri
        case displayName = "display_name"
    }
}
