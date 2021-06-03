//
//  Post.swift
//  SocialNetwork
//
//  Created by rayner on 03/06/21.
//

import Foundation

struct PostUser: Codable, Identifiable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
