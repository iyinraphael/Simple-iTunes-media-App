//
//  Cache.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/3/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

import UIKit

class Cache<Key: Hashable, Value> {
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(for key: Key) -> Value? {
        return queue.sync { cache[key] }
    }
    
    func clear() {
        queue.async {
            self.cache.removeAll()
        }
    }
    
    private var cache = [Key : Value]()
    private let queue = DispatchQueue(label: "com.IyinRaphael.Simple_iTunes_media_App.CacheQueue")
}
