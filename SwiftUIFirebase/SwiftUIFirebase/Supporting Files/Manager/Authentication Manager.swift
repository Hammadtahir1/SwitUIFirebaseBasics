//
//  Authentication Manager.swift
//  SwiftFirebase
//
//  Created by Hamza on 09/02/2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager  {
    
    static let shared = AuthenticationManager()
    
    private init () {
    }
    
    func getAuthenticatedUser() throws -> DBUser{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return DBUser(authUser: user)
        
    }
    
    @discardableResult
    func createUser(email: String , password: String) async throws -> DBUser {
        /// 1. Create Authentication User
        /// Login karega email aur password se
        /// Aur Auth.auth().user mai user create hojayega is line ke baad
        /// Auth.auth().currentUser nil nhi ayega
        /// nil aney ka matlab user login nhi hai ya to app first time install hui hai ya logout kiya hai
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        /// 2. Create User in Firestore Database
        /// If sign-up is successful, this line will be executed
        /// Agar SIgn Up Successfull hoga to yeh line execute hogi
        let AppUser = DBUser(authUser: authDataResult.user)

        /// Return the authentication result model
        return AppUser
        
    }
    
    
    @discardableResult
    func signInUser(email: String , password: String) async throws -> DBUser {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return DBUser(authUser: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await  user.updatePassword(to: password )
    }

    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await  user.updateEmail(to: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
