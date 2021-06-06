//
//  PostTableViewCell.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit
import Imaginary

class PostTableViewCell: UITableViewCell {
    
    
    
    static let kReuseIdentifier = "PostTableViewCell"

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBAction func followButton(_ sender: Any) {
    }
    
    @IBAction func moreButton(_ sender: Any) {
    }
    
    @IBAction func likeButton(_ sender: Any) {
    }
    
    @IBAction func commentButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    
    static func register(inside tableView: UITableView) {
        let nib = UINib(nibName: kReuseIdentifier, bundle: Bundle(for: PostTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: kReuseIdentifier)
    }
    
    func setup(with postUser: PostUser, postImage postUrl: URL, profileImage profileUrl: URL) {
        profileName.text = postUser.title
        profilePictureImageView.setImage(url: profileUrl, placeholder: UIImage(named: "noimage")!)
        postImageView.setImage(url: postUrl, placeholder: UIImage(named: "noimage")!)
    }
    
}
