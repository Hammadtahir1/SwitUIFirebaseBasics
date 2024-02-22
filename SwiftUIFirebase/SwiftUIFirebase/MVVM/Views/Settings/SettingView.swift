//
//  SettingView.swift
//  SwiftFirebase
//
//  Created by Hamza on 09/02/2024.
//

import SwiftUI

//@MainActor
//final class SettingViewModel: ObservableObject {
//
//}

struct SettingView: View {
    
//    @StateObject private var viewmModel = SettingViewModel()
//    @Binding var showsignInView: Bool
    
    @ObservedObject var onboardingVM: OnboardngViewModel
    
    var body: some View {
        List {
            Button("Log out") {
                onboardingVM.signOut()
            }
            
            emailSection
            
        
            if onboardingVM.errorMessage.isEmpty == false {
                Text(onboardingVM.errorMessage)
            }
        }
        .navigationBarTitle("Settings")
    }
}


extension SettingView {
    private var emailSection: some View {
        Section {
            Button("Reset Password ") {
               onboardingVM.resetPassword()
            }
            
            Button("Update Password") {
                onboardingVM.updatePassword()
            }
            
            Button("Update Email") {
                onboardingVM.updateEmail()
            }
            
        } header: {
            Text("Email Functions")
        }

    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView(showsignInView: .constant(false))
//    }
//}
