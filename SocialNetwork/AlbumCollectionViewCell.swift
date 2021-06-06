//
//  AlbumCollectionViewCell.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    static let kReuseIdentifier = "AlbumCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    static func register(inside tableView: UITableView) {
        let nib = UINib(nibName: kReuseIdentifier, bundle: Bundle(for: AlbumCollectionViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: kReuseIdentifier)
    }
    
    func setup(with url: URL) {
        imageView.setImage(url: url, placeholder: UIImage(named: "noimage")!)
    }

}
