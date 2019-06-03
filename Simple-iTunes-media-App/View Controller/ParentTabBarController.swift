//
//  ParentTabBarController.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class ParentTabBarController: UITabBarController {
    
    let movieIcon = UIImage(imageLiteralResourceName: "movie")
    let musicIcon = UIImage(imageLiteralResourceName: "music")

    override func viewDidLoad() {
        super.viewDidLoad()

        let moviesTableViewController = MoviesTableViewController()
        moviesTableViewController.tabBarItem = UITabBarItem(title: "Movies", image: movieIcon, tag: 0)
        
        let musicCollectionViewController = MusicCollectionViewController()
        musicCollectionViewController.tabBarItem = UITabBarItem(title: "Music", image: musicIcon, tag: 1)
        
        let tabBarView = [moviesTableViewController, musicCollectionViewController]
        viewControllers = tabBarView
    }

}
