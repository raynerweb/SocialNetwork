//
//  User+CoreData.swift
//  SocialNetwork
//
//  Created by rayner on 20/06/21.
//

import Foundation
import CoreData

extension User {
    
    func toUserCoreData(in context: NSManagedObjectContext = AppDelegate.viewContext) -> UserCoreData {
        let userCoreData = UserCoreData(context: context)
        userCoreData.email = self.email
        userCoreData.name = self.name
        userCoreData.username = self.username
        return userCoreData
    }
}

