//
//  Artist.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

struct Artist: Codable {
    let externalUrls: ExternalUrls
    //    let followers: Followers
    //    let genres: [String]
    let id: String
    //    let images: [Image]
    let name: String
    //    let popularity: Int
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id, name
    }
}
