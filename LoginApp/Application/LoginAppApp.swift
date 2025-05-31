        //
        //  LoginAppApp.swift
        //  LoginApp
        //
        //  Created by User on 04/03/25.
        //

import UIKit
import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct LoginAppApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewModel = AuthViewModel()
    // MARK:  Scene without tabbar.
    /*  var body: some Scene {
     WindowGroup {
     NavigationStack {
     Group {
     if authViewModel.userSession == nil {
     LoginView()
     
     
     }else {
     MainTabBarView()
     }
     }
     
     }.environmentObject(authViewModel)
     
     }
     }*/
    
    // MARK: Scene  with tabbar
    var body: some Scene {
        WindowGroup {
            if authViewModel.userSession == nil {
                // Login flow with its own NavigationStack
                NavigationStack {
                    LoginView()
                }
                .environmentObject(authViewModel)
            } else {
                // Main app flow with tab bar, each tab has its own NavigationStack
                MainTabBarView()
                    .environmentObject(authViewModel)
            }
        }
    }
    
}
