//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by NguyenHT on 06/04/2022.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}
