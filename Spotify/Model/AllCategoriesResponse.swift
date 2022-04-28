//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by NguyenHT on 28/04/2022.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [Image]
}
