//
//  AudioTrack.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

struct Track: Codable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href, id: String
//    let isPlayable: Bool
    let isLocal: Bool
//    let restrictions: Restrictions
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
//        case isPlayable = "is_playable"
        case isLocal = "is_local"
//        case linkedFrom = "linked_from"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

