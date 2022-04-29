//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by NguyenHT on 29/04/2022.
//

import AVFoundation
import Foundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: Track?
    private var tracks = [Track]()
    
    var index = 0
    
    var currentTrack: Track? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.queuePlayer, !tracks.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item }) else {
//                return nil
//            }
            return tracks[index]
        }
        return nil
    }
    
    var playerVC: PlayerViewController?
    
    var player: AVPlayer?
    var queuePlayer: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController,
                              track: Track) {
        guard let url = URL(string: track.previewURL ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController,
                              tracks: [Track]) {
        self.tracks = tracks
        self.track = nil
        
        self.queuePlayer = AVQueuePlayer(items: tracks.compactMap {
            guard let url = URL(string: $0.previewURL ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        })
        
        self.queuePlayer?.volume = 0
        self.queuePlayer?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }

}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        } else if let queuePlayer = queuePlayer {
            if queuePlayer.timeControlStatus == .playing {
                queuePlayer.pause()
            } else if queuePlayer.timeControlStatus == .paused {
                queuePlayer.play()
            }
        }
    }
    
    func didTapNext() {
        if tracks.isEmpty {
            //not playlist / album
            player?.pause()
        } else if let player = queuePlayer {
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapBack() {
        if tracks.isEmpty {
            //not playlist / album
            player?.pause()
            player?.play()
        } else if let firstItem = queuePlayer?.items().first {
            queuePlayer?.pause()
            queuePlayer?.removeAllItems()
            queuePlayer = AVQueuePlayer(items: [firstItem])
            queuePlayer?.play()
            queuePlayer?.volume = 0
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
}
