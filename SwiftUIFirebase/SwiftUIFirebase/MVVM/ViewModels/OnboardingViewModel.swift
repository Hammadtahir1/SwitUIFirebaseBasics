//
//  OnboardingViewModel.swift
//  SwiftFirebase
//
//  Created by Hamza on 12/02/2024.
//

import Foundation
import FirebaseAuth
import SwiftUI

class OnboardngViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    
    @Published var showSignInView = false
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    @Published var email = ""
    @Published var password = ""
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
        
            guard let _ = user else {
                withAnimation {
                    self.isLoggedIn = false
                }
                return
            }
            
            withAnimation {
                self.isLoggedIn = true
            }
        }
    }
    
    func createUser() {
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                guard !email.isEmpty , !password.isEmpty else {
                    print("No email or password found.")
                    return
                }
                // 1. Create Authentication User to Login
                let dbUser = try await AuthenticationManager.shared.createUser(email: email, password: password)
                
                // 2. Create Database User to store user details
                try await DatabaseManager.shared.createNewUser(user: dbUser)
                
                self.isLoading = false
                self.removeEmailAndPassword()
            }
            catch {
                self.isLoading = false
                self.errorMessage = "SignIn Error: \(error.localizedDescription)"
            }
        }
    }
    
    func signIn() {
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                guard !email.isEmpty , !password.isEmpty else {
                    print("No email or password found.")
                    return
                }
                // 1. Sign In First
                let DBUser = try await AuthenticationManager.shared.signInUser(email: email, password: password)
                
//                try await DatabaseManager.shared.createNewUser1(user: user)
                
//                try await DatabaseManager.shared.createNewUser(user: authDataResult)
                self.isLoading = false
                self.removeEmailAndPassword()
            }
            catch {
                self.isLoading = false
                self.errorMessage = "SignIn Error: \(error.localizedDescription)"
            }
        }
    }
    
    func signOut() {
        do {
            try AuthenticationManager.shared.signOut()
            self.removeEmailAndPassword()
        }
        catch {
            self.errorMessage = "Signout Error: \(error.localizedDescription)"
        }
    }
    func resetPassword() {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
                
                guard let email = authUser.email else {
                    throw URLError(.fileDoesNotExist)
                }
                
                try await AuthenticationManager.shared.resetPassword(email: email)
                print("PASSWORD RESET")
            } catch {
                self.errorMessage = "Reset Password Error: \(error.localizedDescription)"
            }
        }
    }
     
    func updateEmail() {
        Task {
            do {
                let email = "abcdef123@gmail.com"
                try await AuthenticationManager.shared.updateEmail(email: email)
                print("EMAIL UPDATED")
            } catch {
                self.errorMessage = "Reset Password Error: \(error.localizedDescription)"
            }
        }
    }
    func updatePassword() {
        Task {
            do {
                let password = "123456ab"
                try await AuthenticationManager.shared.updatePassword(password: password)
                print("PASSWORD UPDATED")
            } catch {
                self.errorMessage = "Reset Password Error: \(error.localizedDescription)"
            }
        }
    }
    
    private func removeEmailAndPassword() {
        self.errorMessage = ""
        self.email = ""
        self.password = ""

    }
}
