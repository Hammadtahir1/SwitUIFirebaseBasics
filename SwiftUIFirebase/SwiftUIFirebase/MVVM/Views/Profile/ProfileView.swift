//
//  ProfileView.swift
//  SwiftFirebase
//
//  Created by Hamza on 15/02/2024.
//

import SwiftUI


struct ProfileView: View {
    
@StateObject private var viewModel = ProfileViewModel()
    
    @ObservedObject var onboardingVM: OnboardngViewModel
    
    
    var body: some View {
        
        List {
            if let user = viewModel.user {
                Text("User id: \(user.userID)")
                
                
                if let email = user.email {
                    Text("Email: \(email.description.capitalized)")
                }
                
                else if !viewModel.errorMessage.isEmpty {
                    Text("Error: \(viewModel.errorMessage)")
                }
                
                Button {
                    viewModel.togglePremiumStatus()
                } label: {
                    Text("User is Premium: \((user.isPremium  ?? false).description.capitalized)")
                }

                
            }
        }
        
        .task {
            await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing ) {
                NavigationLink {
                    SettingView(onboardingVM: onboardingVM)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(onboardingVM: OnboardngViewModel())
        }
    }
}

