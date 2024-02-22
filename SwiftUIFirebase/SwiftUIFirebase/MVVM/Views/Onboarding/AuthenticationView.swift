//
//  AuthenticationView.swift
//  SwiftFirebase
//
//  Created by Hamza on 07/02/2024.
//

import SwiftUI

struct AuthenticationView: View {
    
    @ObservedObject var onboardingVM: OnboardngViewModel
    
    @State var isPresentSignup = false
    @State var isPresentSignin = false
    
    var body: some View {
        VStack {
            
            Button {
                self.isPresentSignin = true
            }  label: {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            
            Button {
                self.isPresentSignup = true
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationDestination(isPresented: $isPresentSignin) {
            SignInView(onboardingVM: onboardingVM)
        }
        .navigationDestination(isPresented: $isPresentSignup) {
            SignUpView(onboardingVM: onboardingVM)
        }
        
    }
}

//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AuthenticationView(showSignInView: .constant(false) )
//        }
//    }
//}
