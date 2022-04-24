//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by NguyenHT on 13/04/2022.
//

import UIKit
import SDWebImage

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // let text wrap if it needs to
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        
        contentView.addSubview(numberOfTracksLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10,
                                                                height: contentView.height))
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        let albumLabelHeight = min(58, albumLabelSize.height)
        let labelWidth = contentView.width - imageSize - 10
        
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                      y: 5,
                                      width: labelWidth,
                                      height: albumLabelHeight)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                       y: albumNameLabel.bottom + 7,
                                       width: labelWidth,
                                       height: artistNameLabel.height)
        
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                           y: contentView.bottom - 32,
                                           width: labelWidth,
                                           height: numberOfTracksLabel.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
