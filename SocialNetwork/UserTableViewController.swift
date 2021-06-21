//
//  UserTableViewController.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController {
    
    private lazy var fetchRequest: NSFetchRequest<UserCoreData> = {
        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<UserCoreData> = {
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: self.fetchRequest,
            managedObjectContext: AppDelegate.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View foi carregada")
    }
    

    
    // Melhor lugar pra fazer requisicao HTTP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    
                    if let users = try? JSONDecoder().decode([User].self, from: data!) {
                        DispatchQueue.main.async {
                            self.users = users
                        }
                    }
                    
                }
            }
            task.resume()
                      
        }
        
        do {
            try fetchedResultsController.performFetch()
            let usersCoreData: [UserCoreData]? = fetchedResultsController.fetchedObjects
            if let users = usersCoreData {
                users.count
            }
        }catch {
            debugPrint(error)
        }
    }
    
    
    // ALTERANDO PARA COREDATA
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedRestultsController.sections?.count ?? 1
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let sections = fetchedRestultsController.sections, sections.count > 0 {
//            return sections[section].numberOfObjects
//        } else {
//            return 0
//        }
//    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell
//        let userCoreData = fetchedRestultsController.object(at: indexPath)
//        cell.user = userCoreData.toUser()
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row

        let user = users[index]

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell

        cell.user = user

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "onUserSegue" {

            if let userCell = sender as? UserTableViewCell, let user = userCell.user {

                if let destination = segue.destination as? AlbumViewController {
                    destination.title = user.name
                    destination.user = user
                }

            }
        }
    }

}
