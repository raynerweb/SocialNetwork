//
//  SocialTableViewController.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit

class SocialTableViewController: UITableViewController {

    override func viewDidLoad() {
        PostTableViewCell.register(inside: self.tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.kReuseIdentifier, for: indexPath) as! PostTableViewCell
        cell.setup(with: "Rayner")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 630
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
