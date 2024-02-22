//
//  AppUser.swift
//  SwiftFirebase
//
//  Created by Hamza on 15/02/2024.
//

import Foundation
import Firebase

struct DBUser: Codable {
    
    let userID: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date
    var isPremium: Bool?
    
    init(authUser: User) {
        self.userID = authUser.uid
        self.email = authUser.email
        self.photoUrl = authUser.photoURL?.absoluteString
        self.dateCreated = Date.now
        self.isPremium = false
    }
    
    mutating func togglePremium() {
        let isPremium = self.isPremium ?? false
        self.isPremium = !isPremium
    }
}

