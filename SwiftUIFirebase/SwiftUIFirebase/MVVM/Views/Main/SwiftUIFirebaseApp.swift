//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by Hamza on 07/02/2024.
//

import SwiftUI
import Firebase

@main
struct SwiftUIFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
        var body: some Scene {
        WindowGroup {
           RootView()
            
            }
        }
    }


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() 
        return true
    }
}
