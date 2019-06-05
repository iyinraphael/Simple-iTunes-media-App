//
//  MoviesTableViewCell.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: - Property
    var movieImage: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var artistLabel: UILabel = UILabel()

    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.textColor = .white
        artistLabel.textColor = .white
        addSubview(movieImage)
        addSubview(nameLabel)
        addSubview(artistLabel)
        
        movieImage.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: nil, paddingTop: 5,
                          paddingLeft: 5,
                          paddingBottom: 5,
                          paddingRight: 0,
                          width: 150,
                          height: 0,
                          enableInsets: false)
        
        nameLabel.anchor(top: topAnchor,
                         left: movieImage.rightAnchor,
                         bottom: nil,
                         right: nil,
                         paddingTop: 20,
                         paddingLeft: 10,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: frame.size.width / 2,
                         height: 0, enableInsets: false)
        
        artistLabel.anchor(top: nameLabel.bottomAnchor,
                           left: movieImage.rightAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 10,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: frame.size.width / 2,
                           height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




