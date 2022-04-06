//
//  Album.swift
//  Spotify
//
//  Created by NguyenHT on 07/04/2022.
//

import Foundation

struct Album: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [Image]
    let name, releaseDate, releaseDatePrecision: String
    //    let restrictions: Restrictions
    let type, uri: String
    let artists: [Artist]
    //        let tracks: Tracks
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists
        //            tracks
    }
}

//// MARK: - Restrictions
//struct Restrictions: Codable {
//    let reason: String
//}
