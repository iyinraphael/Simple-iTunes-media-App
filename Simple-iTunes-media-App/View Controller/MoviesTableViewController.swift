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
    var results: [Media] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        mediaController.fetchMedia(mediaController.movieUrl) { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  mediaController.results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        let movie = mediaController.results[indexPath.row]
        cell.movie = movie

        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

}
