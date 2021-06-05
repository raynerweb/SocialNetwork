//
//  SocialTableViewController.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import UIKit

class SocialTableViewController: UITableViewController {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private let imageDownloader = ImageDownloader.shared
    
    @IBAction func onRefresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.refreshControl?.endRefreshing()
        }
    }
    
    private var postUsers = [PostUser]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        PostTableViewCell.register(inside: self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageDownloader.beginCachingImages()
        
        if let url = URL(string: "\(kBaseURL)/posts") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    
                    if let postUsers = try? JSONDecoder().decode([PostUser].self, from: data!) {
                        DispatchQueue.main.async {
                            self.postUsers = postUsers
                        }
                    }
                    
                }
            }
            task.resume()
                        
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let postUser = postUsers[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.kReuseIdentifier, for: indexPath) as! PostTableViewCell
        cell.setup(with: postUser, postImage: imageDownloader.randomImage(), profilePictureImage: imageDownloader.randomImage())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 630
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
