//
//  ContentView.swift
//  LoginApp

 
import SwiftUI

struct ContentView: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @StateObject var authViewModel = AuthViewModel()
       
    var body: some View {
        VStack {
            Spacer()
            HStack {
               
                Text(" Login to your \n account ")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.horizontal, 40)
            TextField("Email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
            
            Button {
                print("Login button got tapped")
            } label: {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(.blue)
                    .cornerRadius(20)
                    .shadow(color: .black ,radius: 1,y: 2 )
                    .fontWeight(.black)
            
             
                    
            }
            .padding()
            .onTapGesture {
                print(" Login Button is clicked ")
            }
            
            HStack {
                Spacer()
                Button {
                    print("Forgot password tapped")
                } label: {
                    Text("Forgot Password ? ")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        
                    
                }
               
            } .padding(.trailing, 60)
            
            
            VStack(alignment:.center, spacing: 20) {
                
                SocialLoginButton(iconName: "icons8-google-48", title: "Sign with google     ", backgroundColor: Color.white, textColor: .blue , action:     {
                    
                    authViewModel.signInWithGoogle()
                })
                SocialLoginButton(iconName: "icons8-facebook-48", title: "Sign with Facebook", backgroundColor: Color.white, textColor: .blue , action:     {
                    
                     print("Facebok  button tapped")
                })
                SocialLoginButton(iconName: "icons8-apple-logo-30", title: "Sign with apple id ", backgroundColor: Color.white, textColor: .blue , action:     {
                    
                    authViewModel.signInWithApple()
                
                })
                
            }.padding()
            Spacer()
            HStack {
                Text("Don't have an account ? ")
                Button {
                    print("Sign up button tapped")
                } label: {
                    Text("Sign up")
                }

                
            }

            
            
            
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct SocialLoginButton: View {
    var iconName: String = ""
    var title: String = "Sign in with google"
    var backgroundColor: Color =  Color.white
    var textColor: Color = Color.blue
    var action: () -> Void = { print (" Button got tapped ")}
    
    var body: some View {
        Button(action: action) {
            HStack (  spacing:16) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(textColor)
            }
            
            .frame(width: 250, height: 50)
            .background(backgroundColor)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
            )
        }
    }
}
