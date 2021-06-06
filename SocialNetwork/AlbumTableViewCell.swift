//
//  AlbumTableViewCell.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    static let kReuseIdentifier = "AlbumTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
  
    static func register(inside tableView: UITableView) {
        let nib = UINib(nibName: kReuseIdentifier, bundle: Bundle(for: AlbumTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: kReuseIdentifier)
    }
    
    func setup(with album: Album) {
        titleLabel.text = album.title
        
//        profilePictureImageView.setImage(url: profileUrl, placeholder: UIImage(named: "noimage")!)
//        postImageView.setImage(url: postUrl, placeholder: UIImage(named: "noimage")!)
    }
}
