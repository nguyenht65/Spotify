//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by NguyenHT on 25/04/2022.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [Image]
    let label: String
    let name, releaseDate, releaseDatePrecision: String
    let popularity: Int
    let totalTracks: Int
    let tracks: TracksResponse
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case artists
        case popularity
        case label
        case tracks
    }
}

struct TracksResponse: Codable {
    let items: [Track]
}
