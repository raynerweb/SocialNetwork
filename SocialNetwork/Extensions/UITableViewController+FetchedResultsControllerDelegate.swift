//
//  TableViewController+FetchedResultsControllerDelegate.swift
//  SocialNetwork
//
//  Created by rayner on 20/06/21.
//

import Foundation
import CoreData
import UIKit

extension UITableViewController: NSFetchedResultsControllerDelegate {
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
     
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections([sectionIndex], with: .bottom)
        case .delete:
            tableView.deleteSections([sectionIndex], with: .bottom)
        case .update:
            tableView.reloadSections([sectionIndex], with: .automatic)
        default:
            break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        if let index = indexPath {
            switch type {
            case .insert:
                tableView.insertRows(at: [index], with: .left)
            case .delete:
                tableView.deleteRows(at: [index], with: .left)
            case .update:
                tableView.reloadRows(at: [index], with: .middle)
            case .move:
                tableView.moveRow(at: index, to: newIndexPath!)
            @unknown default:
                break
            }
        }

        
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
}
