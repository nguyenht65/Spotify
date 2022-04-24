//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by NguyenHT on 13/04/2022.
//

import UIKit
import SDWebImage

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // let text wrap if it needs to
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.sizeToFit()
        playlistNameLabel.sizeToFit()
        
        let imageSize = contentView.height - 70
        
        playlistCoverImageView.frame = CGRect(x: (contentView.width - imageSize) / 2,
                                              y: 3,
                                              width: imageSize,
                                              height: imageSize)
        
        playlistNameLabel.frame = CGRect(x: 3,
                                         y: playlistCoverImageView.bottom + 6,
                                         width: contentView.width - 6,
                                         height: playlistNameLabel.height)
        
        creatorNameLabel.frame = CGRect(x: 3,
                                        y: playlistNameLabel.bottom + 6,
                                        width: contentView.width - 6,
                                        height: creatorNameLabel.height)
        

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
