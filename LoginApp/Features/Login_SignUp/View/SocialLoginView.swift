//
//  SocialLoginView.swift
//  LoginApp
//
//  Created by User on 31/05/25.
//

import SwiftUI

struct SocialLoginView: View {
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
#Preview {
    SocialLoginView()
}
