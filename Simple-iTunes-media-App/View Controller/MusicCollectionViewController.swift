//
//  MusicCollectionViewController.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit



class MusicViewController: UIViewController {

    
    
    //MARK: - Property
    var reuseIdentifier = "MusicCollectionViewCell"
    var musicCollecViewController: UICollectionView!
    let mediaController = MediaController()
    private let cache = Cache<Int, UIImage>()
    private var operations = [Int : Operation]()
    private let imageFetchQueue = OperationQueue()
    let layout = UICollectionViewFlowLayout()
    
    override func loadView() {
        super.loadView()
       
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        self.musicCollecViewController = collectionView

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicCollecViewController.dataSource = self
        musicCollecViewController.delegate = self
        musicCollecViewController.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        guard let url = mediaController.musicUrl else {return}
        mediaController.fetchMedia(url) { (results, _) in
            DispatchQueue.main.async {
                self.musicCollecViewController.reloadData()
            }
        }
        setupCollectView()
    }
    
    func setupCollectView() {
        musicCollecViewController.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        musicCollecViewController.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        musicCollecViewController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        musicCollecViewController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    //MARK: - Cache and Concurrency(NSOperation)
    private func loadImage(forCell cell: MusicCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let media = mediaController.results[indexPath.item]
        
        guard let id = Int(media.identifier) else {return}
        if let cachedImage = cache.value(for: id as Int) {
            cell.imageView.image = cachedImage
            cell.artistLabel.text = media.artist
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
            
            if let currentIndexpath = self.musicCollecViewController.indexPath(for: cell),
                currentIndexpath != indexPath {
                return
            }
            
            DispatchQueue.main.async {
                if let image = fetchOp.image {
                    cell.imageView.image = image
                    cell.artistLabel.text = media.artist
                }
                self.musicCollecViewController.reloadData()
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


extension MusicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mediaController.results.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MusicCollectionViewCell else {return UICollectionViewCell()}
            loadImage(forCell: cell, forItemAt: indexPath)
            return cell
        }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            var totalUsableWidth = collectionView.frame.width
            let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
            totalUsableWidth -= inset.left + inset.right
            
            let minWidth: CGFloat = 150.0
            let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
            totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
            let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
            return CGSize(width: width, height: width)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        }
    }





