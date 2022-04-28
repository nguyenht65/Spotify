//
//  SearchResult.swift
//  Spotify
//
//  Created by NguyenHT on 28/04/2022.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: Track)
}
