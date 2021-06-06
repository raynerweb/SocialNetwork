//
//  AlbumViewController.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import UIKit

class AlbumViewController: UIViewController {

    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: User?
    
    private var albums = [Album]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumTableViewCell.register(inside: self.tableView)
        usernameLabel.text = user?.name
        emailLabel.text = user?.email
    }
     
    override func viewWillAppear(_ animated: Bool) {
        
        if let userId = user?.id {
            if let url = URL(string: "\(kBaseURL)/users/\(userId)/albums") {
                let session = URLSession.shared
                let request = URLRequest(url: url)
                
                let task = session.dataTask(with: request) { (data, resp, error) in
                    if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                        
                        if let albums = try? JSONDecoder().decode([Album].self, from: data!) {
                            DispatchQueue.main.async {
                                self.albums = albums
                            }
                        }
                        
                    }
                }
                task.resume()
            }
        }
    }

}

extension AlbumViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let album = albums[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.kReuseIdentifier, for: indexPath) as! AlbumTableViewCell
        cell.setup(with: album)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

