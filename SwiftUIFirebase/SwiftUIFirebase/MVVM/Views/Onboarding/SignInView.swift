//
//  SignInEmailView.swift
//  SwiftFirebase
//
//  Created by Hamza on 07/02/2024.
//

import SwiftUI

struct SignInView: View {
    
//    @StateObject private var viewModel = SignInEmailViewModel()
    @ObservedObject var onboardingVM: OnboardngViewModel
//    @Binding var showSignInView: Bool
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                
                TextField("Email...", text: $onboardingVM.email)
                    .padding()
                    .background(Color.gray.opacity(0.5) )
                    .cornerRadius(12)
                
                SecureField("Password...", text: $onboardingVM.password)
                    .padding()
                    .background(Color.gray.opacity(0.5) )
                    .cornerRadius(12)
                
                Button {
                    onboardingVM.signIn()
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if onboardingVM.errorMessage.isEmpty == false {
                    Text("Sign in Error: \(onboardingVM.errorMessage)")
                }
            }
            .padding()
            
            if onboardingVM.isLoading {
                ProgressView()
            }
            
        }
        .navigationTitle("Sign In With Email")
    }
}

//struct SignInEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SignInEmailView(showSignInView: .constant(false))
//        }
//    }
//}
