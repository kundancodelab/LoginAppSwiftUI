//
//  Users.swift
//  LoginApp
//
//  Created by User on 04/03/25.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let fullName: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "email": email,
            "fullName": fullName
        ]
    }
}

