//
//  Media.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

struct Media: Codable {
    
    let name: String
    let artist: String
    let image: String
    let mediaType: String
    
    
    enum CodingKeys: String, CodingKey {

        case name = "name"
        case artist = "artistName"
        case image = "artworkUrl100"
        case mediaType = "kind"
   
    }

}


struct Results: Decodable {
    
    var feed: feeds
    
    
    struct feeds: Decodable {
        
        var results: [Media]
    
    }

}
