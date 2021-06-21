//
//  User+CoreData.swift
//  SocialNetwork
//
//  Created by rayner on 20/06/21.
//

import Foundation
import CoreData

extension User {
    
    func saveInCoreData(in context: NSManagedObjectContext = AppDelegate.viewContext) {
        let userCoreData = UserCoreData(context: context)
        userCoreData.email = self.email
        userCoreData.name = self.name
        userCoreData.username = self.username
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
}

