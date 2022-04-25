//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist: Playlist
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
        APICaller.shared.getPlaylistDetails(for: playlist) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
        
    }
}
