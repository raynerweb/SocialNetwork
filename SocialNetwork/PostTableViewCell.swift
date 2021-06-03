//
//  PostTableViewCell.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit

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
    
    func setup(with postUser: PostUser) {
        profileName.text = postUser.title
        
        profilePictureImageView.image = UIImage(data: try! Data(contentsOf: URL(string: "https://picsum.photos/120/120")!))
        
        let width = Int(UIScreen.main.nativeBounds.size.width)
        let height = Int(width * (16/9))
        
        postImageView.image = UIImage(data: try! Data(contentsOf: URL(string: "https://picsum.photos/\(width)/\(height)")!))
    }
    
}
