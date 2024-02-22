//
//  SignUpView.swift
//  SwiftFirebase
//
//  Created by Hamza on 13/02/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var onboardingVM: OnboardngViewModel
    
    
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
                    onboardingVM.createUser()
                } label: {
                    Text("Sign up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if onboardingVM.errorMessage.isEmpty == false {
                    Text("Sign up Error: \(onboardingVM.errorMessage)")
                }
            }
            .padding()
            
            if onboardingVM.isLoading {
                ProgressView()
            }
            
        }
        .navigationTitle("Create User With Email")
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
