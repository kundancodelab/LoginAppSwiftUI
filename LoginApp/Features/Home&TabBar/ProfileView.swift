//
//  ProfileView.swift
//  LoginApp
//
//  Created by User on 31/05/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isLoading:Bool = false
    @State private var loaderMessege:String = "signing out..."
    @State private var isNavigateToCardsdetails:Bool = false
   
    var body: some View {
        ZStack {
            VStack {
            if let user = authViewModel.currentUser {
                List {
                    Section {
                        HStack(spacing: 16) {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(.lightGray))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Text(user.email)
                                    .font(.footnote)
                            }
                        }
                    }
                    
                    Section("Accounts") {
                        Button {
                            isNavigateToCardsdetails = true
                        } label: {
                            Label {
                                Text("Cards Details")
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "creditcard.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        Button {
                            isLoading = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 , execute: {
                                authViewModel.signOut()
                                if !authViewModel.isError {
                                    isLoading = false
                                }
                            })
                        }
                           
                         label: {
                            Label {
                                Text("Sign Out")
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        Button {
                          
                           
                                Task {
                                    isLoading = true
                                    await authViewModel.deleteAccount()
                                    if !authViewModel.isError {
                                        isLoading = false
                                    }else {
                                        isLoading = false
                                    }
                                }
                            
                           
                        } label: {
                            Label {
                                Text("Delete Account")
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                    }
                }
            }else {
                ProgressView("Please wait...")
                
                VStack {
                    Text("Currently there is no currently user logged in")
                }
            }
                
                  
                
        }
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true)
            .padding()
            .navigationDestination(isPresented: $isNavigateToCardsdetails)  {
                MainPaymentView()
                    .toolbar(.hidden, for: .tabBar)
            }
            if isLoading {
                CustomLoader()
            }
        }
       
        
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
   
}
