//
//  UserTableViewController.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController , NSFetchedResultsControllerDelegate {
    
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
    
    private var users = [User]()
//    {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View foi carregada")
    }
    

    
    // Melhor lugar pra fazer requisicao HTTP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try fetchedResultsController.performFetch()
            let usersCoreData: [UserCoreData]? = fetchedResultsController.fetchedObjects
            if let users = usersCoreData {
                if users.isEmpty {
                    getUsersFromAPI()
                }
//                else {
//                    self.users = users.map { $0.toUser() }
//                }
            }
        }catch {
            debugPrint(error)
        }
    }
    
    private func getUsersFromAPI() {
        let context = AppDelegate.viewContext
        
        if let url = URL(string: "\(kBaseURL)/users") {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    
                    if let users = try? JSONDecoder().decode([User].self, from: data!) {
                        DispatchQueue.main.async {
                            
                            
                            var userCoreDataList: [UserCoreData] = []

                            for user in users {
                                userCoreDataList.append(user.toUserCoreData())
                            }

                            do {
                                try context.save()
                                print("Success")
                            } catch {
                                print("Error saving: \(error)")
                            }
                            
                            self.users = users
                            
                        }
                    }
                    
                }
            }
            task.resume()
                      
        }
    }
    
    
    // ALTERANDO PARA COREDATA
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedResultsController.sections?.count ?? 1
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController.fetchedObjects?.count ?? 0
//        if let sections = fetchedResultsController.sections, sections.count > 0 {
//            return sections[section].numberOfObjects
//        } else {
//            return 0
//        }
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.users.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell
        let userCoreData = fetchedResultsController.object(at: indexPath)
        cell.user = userCoreData.toUser()
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let index = indexPath.row
//
//        let user = users[index]
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! UserTableViewCell
//
//        cell.user = user
//
//        return cell
//    }
    
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
    
    
//    controller
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
//        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
//        table
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell {
                let userCoreData = fetchedResultsController.object(at: indexPath)
                cell.user = userCoreData.toUser()
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }

            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            break;
        }
    }

    
//    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = <#Get the cell#>
//        guard let object = self.fetchedResultsController?.object(at: indexPath) else {
//            fatalError("Attempt to configure cell without a managed object")
//        }
//        // Configure the cell with data from the managed object.
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let sectionInfo = fetchedResultsController?.sections?[section] else {
//            return nil
//        }
//        return sectionInfo.name
//    }
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return fetchedResultsController?.sectionIndexTitles
//    }
//    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        guard let result = fetchedResultsController?.section(forSectionIndexTitle: title, at: index) else {
//            fatalError("Unable to locate section for \(title) at index: \(index)")
//        }
//        return result
//    }

}
