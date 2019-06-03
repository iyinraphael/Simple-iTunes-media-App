//
//  MediaController.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation


class MediaController {
    
    //MARK: -PROPERTIES
    let movieUrl = URL(string: "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/50/explicit.json")!
    let musicUrl = URL(string: "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/50/explicit.json")!
    typealias completionHandler = ([Results]?,Error?) -> Void
    var results: Array<Results>?
    
}
