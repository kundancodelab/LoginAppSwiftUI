import SwiftUI

struct LoginView: View {
    // MARK: - State & ViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignUpTap: Bool = false
    @State private var isLoading:Bool = false
    @State private var isNavigateHome:Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack {
                    Text("Login to your \naccount")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                // MARK: - Email & Password Fields
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .textContentType(.password)
                
                
                // MARK: - Login Button
                
                Button(action: {
                        Task {
                            isLoading = true
                            await authViewModel.login(email: email, password: password)
                            if !authViewModel.isError {
                                UserDefaults.standard.set(true, forKey: "isSignIn")
                                UserDefaults.standard.set(authViewModel.currentUser?.uid, forKey: "UserId")
                                isLoading = false
                            }else {
                                // there is error
                                isLoading = false
                            }
                        }
                    
                   
                  
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(.blue)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 1, y: 2)
                        .fontWeight(.black)
                }
                .padding()
                // MARK: - Forgot Password
                HStack {
                    Spacer()
                    Button(action: {
                        print("Forgot password tapped")
                        isSignUpTap = true
                    }) {
                        Text("Forgot Password?")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.trailing, 60)
                
                // MARK: - Social Login Buttons
                VStack(alignment: .center, spacing: 20) {
                    SocialLoginView(
                        iconName: "icons8-google-48",
                        title: "Sign in with Google",
                        backgroundColor: .white,
                        textColor: .blue,
                        action: {
                           print("Google Button tapps")
                        }
                    )
                    
                    SocialLoginView(
                        iconName: "icons8-facebook-48",
                        title: "Sign in with Facebook",
                        backgroundColor: .white,
                        textColor: .blue,
                        action: {
                            print("Facebook button tapped")
                        }
                    )
                    
                    SocialLoginView(
                        iconName: "icons8-apple-logo-30",
                        title: "Sign in with Apple ID",
                        backgroundColor: .white,
                        textColor: .blue,
                        action: {
                          print("Apple button tapped")
                        }
                    )
                }
                .padding()
                
                Spacer()
                // MARK: - Sign Up Link Button
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                    isSignUpTap = true
                        print("Sign up button tapped")
                    }) {
                        Text("Sign up")
                            .foregroundColor(.blue)
                    }
                }
                .navigationDestination(isPresented: $isSignUpTap) {
                    SignUpView()
                      
                }
              
               
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            if isLoading {
                CustomLoader()
            }
        }
       
        
       
    }
}



#Preview {
    NavigationStack{
        LoginView()
            .environmentObject(AuthViewModel())
    }
   
}
