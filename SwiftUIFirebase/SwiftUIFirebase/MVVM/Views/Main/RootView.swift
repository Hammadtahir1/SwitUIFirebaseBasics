//
//  RootView.swift
//  SwiftFirebase
//
//  Created by Hamza on 09/02/2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var onboardingVM = OnboardngViewModel()
    
    var body: some View {
        ZStack {
            if onboardingVM.isLoggedIn {
                NavigationStack {
                    ProfileView(onboardingVM: onboardingVM)
                }
            }
            else {
                NavigationStack {
                    AuthenticationView(onboardingVM: onboardingVM)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
