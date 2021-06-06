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
        
    }
}

extension AlbumTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.kReuseIdentifier, for: indexPath)
            as! AlbumCollectionViewCell
        if let url = URL(string: "https://picsum.photos/40/40?\(index)"){
            cell.setup(with: url)
        }
        return cell
    }
    
    
}

extension AlbumTableViewCell : UICollectionViewDelegate {
    
}
