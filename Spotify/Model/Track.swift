//
//  AudioTrack.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

struct Track: Codable {
    let album: Album?
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let id: String
//    let isPlayable: Bool
    let isLocal: Bool
    let name: String
    let previewURL: String?
    let popularity: Int?
    let trackNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case id
//        case isPlayable = "is_playable"
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
    }
}

