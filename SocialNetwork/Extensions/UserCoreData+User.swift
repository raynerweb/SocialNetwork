//
//  UserCoreData+User.swift
//  SocialNetwork
//
//  Created by rayner on 20/06/21.
//

import Foundation
import CoreData

extension UserCoreData {
    
    func toUser() -> User {
        let user = User(id: Int(self.userId), name: self.name ?? "", username: self.username ?? "", email: self.email ?? "")
        return user
    }
}
