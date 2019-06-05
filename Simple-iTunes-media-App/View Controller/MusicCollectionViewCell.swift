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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let artistLabel: UILabel = {
        let artistLabel = UILabel()
        return artistLabel
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    func updateView() {
        addSubview(nameLabel)
        addSubview(artistLabel)
        addSubview(imageView)
        
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 10, y: 10, width: 150, height: 150)
        stackView.axis = .vertical
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(artistLabel)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
