//
//  AuthManager.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "89dbf3cb80c649b38d571f71f2d11a04"
        static let clientSecret = "0fe080b30a9640169bf10516b71a0de7"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURL = "https://github.com/nguyenht65/Spotify"
        let base = "https://accounts.spotify.com/authorize"
        let stringURL = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURL)&show_dialog=TRUE"
        return URL(string: stringURL)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)) {
            // get token
        }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
