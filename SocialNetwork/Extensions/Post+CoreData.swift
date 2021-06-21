//
//  Post+CoreData.swift
//  SocialNetwork
//
//  Created by rayner on 20/06/21.
//

import Foundation
import CoreData

extension PostUser {
    
    func toPostCoreData(in context: NSManagedObjectContext = AppDelegate.viewContext) -> PostCoreData {
        let postCoreData = PostCoreData(context: context)
        
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId = %@", self.userId)
        
        let results = try! context.fetch(fetchRequest)
        //let results = try! fetchRequest.execute();
        if results.count > 0 {
            let author = results.first
            postCoreData.author = author
        }
        
        postCoreData.body = self.body
        postCoreData.postId = Int32(self.id)
        postCoreData.title = self.title
        return postCoreData
    }
}
