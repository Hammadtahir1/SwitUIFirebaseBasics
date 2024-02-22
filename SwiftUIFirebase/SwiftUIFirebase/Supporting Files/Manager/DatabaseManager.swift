//
//  DatabaseManager.swift
//  SwiftFirebase
//
//  Created by Hamza on 15/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let usersReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        usersReference.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try self.usersReference.document(user.userID).setData(from: user)
    }
    
    func getUser(userId: String) async throws -> DBUser {

        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()

        let dbUser = try snapshot.data(as: DBUser.self)

        return dbUser
    }
     
    func updateUserPremiumStatus(user: DBUser) async throws {
        try userDocument(userId: user.userID).setData(from: user , merge: true)
    }
    
    func updateUserPremiumStatus(userId: String , isPremium: Bool) async throws {
        
        let data:[String:Any] = [
            
            "is_Premium" : isPremium
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    
    
    
    
    
    
    
    
    /*
    private func userDocument(userId: String) -> DocumentReference {
        usersReference.document(userId)
        
    }
     
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
     */
    

    /*
    func createNewUser1(user: AppUser) async throws {
        try userDocument(userId: user.userID).setData(from: user , encoder: encoder)
        
    }
    
    
    /// This function creates a new user in the Firestore collection named "users".
    /// It stores the user's ID, email, and the time the user was created in the database.
    func createNewUser(user: AppUser) async throws {
        // Check if there is a currently authenticated user
        guard let authUser = Auth.auth().currentUser else {
            // If there is no authenticated user, exit the function
            return
        }
        
        // Get the user's ID
        let userID = authUser.uid
        
        // Get the user's email
        guard let email = authUser.email else {
            // If the user's email is not available, exit the function
            return
        }
        
//         Create a dictionary representing user data

        let newUserData: [String: Any] = [
            "userID": userID,                   // User's unique ID
            "email": email,                     // User's email address
            "dateCreated": Date()               // Timestamp representing the time the user was created
        ]

        // Add the user data to the "users" collection in Firestore
        try await usersReference.document(userID).setData(newUserData)
    }
     */
} 
