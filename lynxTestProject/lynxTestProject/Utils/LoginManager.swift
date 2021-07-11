//
//  LoginManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import FirebaseAuth

enum LoginError: String {
    case wrongPassword = "Wrong Password"
    case invalidEmail = "Please enter a valid email"
    case noData = "Please enter your username and password"
}

protocol LoginDelegate {
    func login()
    func signalError(_ error: LoginError)
}

class LoginManager {
    var delegate: LoginDelegate?
    
    func login(email: String, password: String) {
        if email == "" || password == "" {
            delegate?.signalError(LoginError.noData)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let auth = authResult {
                User.uid = auth.user.uid
            }
            else if let error = error, let errCode = AuthErrorCode(rawValue: error._code) {
                switch errCode {
                case .wrongPassword:
                    self.delegate?.signalError(.wrongPassword)
                case .invalidEmail:
                    self.delegate?.signalError(.invalidEmail)
                default:
                    return
                }
            }
            self.save(email: email, password: password)
            User.email = email
            self.delegate?.login()
        }
    }
    
    private func save(email: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(email, forKey: "email")
        defaults.setValue(password, forKey: "password")
    }
}
