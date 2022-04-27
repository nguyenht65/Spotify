//
//  TittleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by NguyenHT on 27/04/2022.
//

import UIKit

class TittleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TittleHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 15, y: 0, width: width - 30, height: height)
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
