//
//  MoviesTableViewController.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    //MARK: - Property
    var reuseIdentifier = "tableCell"
    let mediaController = MediaController()
    private let cache = Cache<Int, UIImage>()
    private var operations = [Int : Operation]()
    private let imageFetchQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode()
        Appearance.setTheme()
        tableView.separatorStyle = .none
        guard let url = mediaController.movieUrl else {return}
        mediaController.fetchMedia(url) { (_, _) in
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
   
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  mediaController.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        
        loadImage(forCell: cell, forItemAt: indexPath)

        return cell
    }
    
    //MARK: - Cache and Concurrency(NSOperation)
    private func loadImage(forCell cell: MoviesTableViewCell, forItemAt indexPath: IndexPath) {
        
        let media = mediaController.results[indexPath.item]
    
        guard let id = Int(media.identifier) else {return}
        if let cachedImage = cache.value(for: id as Int) {
            cell.movieImage.image = cachedImage
            cell.artistLabel.text = media.artist
            cell.nameLabel.text = media.name
            return
        }
        let fetchOp = FetchImageOperation(media: media)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: id)
            }
        }
        let completionOp = BlockOperation {
            defer {self.operations.removeValue(forKey:id)}
            
            if let currentIndexpath = self.tableView.indexPath(for: cell),
                currentIndexpath != indexPath {
                return
            }
            
            DispatchQueue.main.async {
                if let image = fetchOp.image {
                    cell.movieImage.image = image
                    cell.artistLabel.text = media.artist
                    cell.nameLabel.text = media.name
                }
                self.tableView.reloadData()
            }
        }
            
            cacheOp.addDependency(fetchOp)
            completionOp.addDependency(fetchOp)
            
            imageFetchQueue.addOperation(fetchOp)
            imageFetchQueue.addOperation(cacheOp)
            OperationQueue.main.addOperation(completionOp)
    
            operations[id] = fetchOp
    }
    
}

