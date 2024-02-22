//
//  ProfileViewModel.swift
//  SwiftFirebase
//
//  Created by Hamza on 15/02/2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject  {

    @Published private(set) var user: DBUser? = nil

    @Published var errorMessage = ""

    func loadCurrentUser() async {
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.user = try await DatabaseManager.shared.getUser(userId: authDataResult.userID)
        }
        catch {
            print(#function, error)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func togglePremiumStatus() {
        Task {
            
            guard var updatedUser = self.user else {
                return
            }
            let currentValue = user?.isPremium ?? false
            updatedUser.togglePremium()
            
            try await DatabaseManager.shared.updateUserPremiumStatus(userId: user!.userID, isPremium: !currentValue )
             
            self.user = updatedUser
        }
    }
}
