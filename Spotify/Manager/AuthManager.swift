//
//  AuthManager.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    struct Constants {
        static let clientID = "89dbf3cb80c649b38d571f71f2d11a04"
        static let clientSecret = "0fe080b30a9640169bf10516b71a0de7"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURL = "https://github.com/nguyenht65/Spotify"
        static let scopes = "user-read-private%20user-read-email%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let stringURL = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
        return URL(string: stringURL)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // get token
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURL)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        //get base64 string
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64: ")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    ///Supplies valid token to be used with API Calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            // Refresh
            refreshAccessTokenIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshAccessTokenIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else { // if token is refreshing -> return
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        //Refresh token
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        //get base64 string
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64: ")
            completion?(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach { $0(result.accessToken) }
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                completion?(true)
            } catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        if let refresh_token = result.refreshToken {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expirationDate")
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
    }
}
