//
//  User.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
