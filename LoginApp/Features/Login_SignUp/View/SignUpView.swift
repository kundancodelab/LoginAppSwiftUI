//
//  SignUpView.swift
//  LoginApp
//
//  Created by User on 31/05/25.
//

import SwiftUI
import ProgressHUD

struct SignUpView: View {
    // MARK: States Properties
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNavigateToHome: Bool = false
    @State private var isLoading:Bool =  false
    @EnvironmentObject var authViewModel: AuthViewModel
  
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Please complete all information to create an account.")
                    .font(.headline).fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                // MARK: Input fields
                InputView(
                    placeholder: "Email or Phone number",
                    text: $email
                ).autocorrectionDisabled()
                    .autocapitalization(.none)
                
                InputView(
                    placeholder: "Full Name",
                    text: $fullName
                ).autocorrectionDisabled()
                
                InputView(
                    placeholder: "Password",
                    isSecureField: true,
                    text: $password
                ).autocorrectionDisabled()
                    .autocapitalization(.none)
                    .textContentType(.newPassword)
                // MARK: Confirm Password Fileds and validates
                ZStack(alignment: .trailing) {
                    InputView(
                        placeholder: "Confirm your password",
                        isSecureField: true,
                        text: $confirmPassword
                    ).autocorrectionDisabled()
                        .autocapitalization(.none)
                        .textContentType(.newPassword)
                    
                    Spacer()
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: "\(isValidPassword ? "checkmark" : "xmark").circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword ? Color(.systemGreen) : Color(.systemRed))
                    }
                }
                
                Spacer()
                // MARK: Create Account Button
                Button {
                    Task {
                        isLoading = true
                        await authViewModel.createUser(
                            email: email,
                            fullName: fullName,
                            password: password
                        )
                        
                        if !authViewModel.isError   {
                            UserDefaults.standard.set(true, forKey: "isSignIn")
                            UserDefaults.standard.set(authViewModel.currentUser?.uid, forKey: "UserId")
                            isNavigateToHome = true
                            isLoading = false
                        }else {
                            isLoading = false
                        }
                    }
                } label: {
                    Text("Create Account")
                }
                .buttonStyle(CapsuleStyleBtn())
                
                
            }
            .navigationTitle("Set up your account")
            .toolbarRole(.editor)
            .padding()
            .navigationDestination(isPresented: $isNavigateToHome) {
                MainTabBarView()
                
            }
            if isLoading {
                CustomLoader()
            }
            
        }
        
    }
    
    var isValidPassword: Bool {
        confirmPassword == password
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
