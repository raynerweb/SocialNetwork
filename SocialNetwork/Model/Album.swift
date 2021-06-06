//
//  Album.swift
//  SocialNetwork
//
//  Created by rayner on 06/06/21.
//

import Foundation

struct Album: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
}
