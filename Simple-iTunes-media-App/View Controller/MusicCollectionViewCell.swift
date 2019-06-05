//
//  MusicCollectionViewCell.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/4/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super .init(frame: frame)
        updateView()
    }
    
    let artistLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.frame = CGRect(x: 0, y: 125, width: 150, height: 15)
        artistLabel.textAlignment = .center
        artistLabel.textColor = .white
        artistLabel.font.withSize(10)
        return artistLabel
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 120)
        return imageView
    }()
    
    
    
    func updateView() {
        addSubview(artistLabel)
        addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
