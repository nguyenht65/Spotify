//
//  AuthResponse.swift
//  Spotify
//
//  Created by NguyenHT on 04/04/2022.
//

import Foundation

// MARK: - AuthResponse
struct AuthResponse: Codable {
    let accessToken, tokenType, scope: String
    let expiresIn: Int
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
