//
//  MainTabBar.swift
//  LoginApp
//
//  Created by User on 31/05/25.
//
import SwiftUI

struct MainTabBarView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Chats", systemImage: "message")
            }

            NavigationStack {
               // MessagesView()
            }
            .tabItem {
                Label("Commuinties", systemImage: "person.3")
            }

            NavigationStack {
               
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainTabBarView()
        
}


