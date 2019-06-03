//
//  Networking.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation


extension MediaController {
    
    private func fetchMedia(_ withUurl: URL, completion: @escaping completionHandler = {_, _ in }) {
        
        URLSession.shared.dataTask(with: withUurl) { (data, _, error) in
            
            if let error = error {
                
                NSLog("Could not fetch data from server \(error)")
            }
            
            guard let data = data else {
                NSLog("No data from data task")
                completion(nil, error)
                return
            }
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode([Results].self, from: data)
                self.results = results
               
                completion(self.results, nil)
                
            } catch {
                
                NSLog("Error decoding JSON data: \(error)")
                completion(nil, error)
                
                return
            }
        }.resume()
    }
}
