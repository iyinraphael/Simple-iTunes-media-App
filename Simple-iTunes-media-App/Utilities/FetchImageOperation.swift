//
//  FetchImageOperation.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/3/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit


class FetchImageOperation: ConcurrentOperation {
    
    init(media: Media , session: URLSession = URLSession.shared) {
        self.media = media
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        let imageString = media.image
        guard let imageUrl = URL(string: imageString) else {return}
        
        let task = session.dataTask(with: imageUrl) { (data, response, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for \(self.media): \(error)")
                return
            }
            
            if let data = data {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
    // MARK: Properties
    let media: Media
    private let session: URLSession
    private(set) var image: UIImage?
    private var dataTask: URLSessionDataTask?
}



