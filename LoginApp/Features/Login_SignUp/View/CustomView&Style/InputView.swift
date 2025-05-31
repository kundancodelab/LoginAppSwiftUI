//
//  InputView.swift
//  LoginApp
//
//  Created by User on 31/05/25.
//


import SwiftUI

struct InputView: View {
    let placeholder: String
    var isSecureField: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            if isSecureField {
                SecureField(placeholder, text: $text)
            }else {
                TextField(placeholder, text: $text)
            }
            
            Divider()
        }
    }
}

#Preview {
    InputView(
        placeholder: "Email or Phone number",
        text: .constant("")
    )
}

