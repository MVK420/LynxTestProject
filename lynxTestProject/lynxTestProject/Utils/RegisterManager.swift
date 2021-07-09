//
//  RegisterManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit
import FirebaseAuth

enum RegisterError: String {
    case noEmail = "Please enter your email"
    case noPassword = "Please enter your password"
    case noCofirmPassword = "Please confirm your password"
    case noMatch = "Your passwords don't match"
    case alreadyUsed = "This email is already registered"
    case passwordShort = "This password is too short"
    case termsNot = "Please accept our terms and conditions"
}

protocol RegisterDelegate {
    func signalError(error: RegisterError)
    func login()
}

class RegisterManager {
    var delegate: RegisterDelegate?
    
    func validateData(email: String, password: String, confirmPassword: String, termsAccepted: Bool) {
        if checkEmail(email) && checkPasswords(password, confirmPassword) && checkTerms(termsAccepted) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error, let errCode = AuthErrorCode(rawValue: error._code) {
                    if errCode == .emailAlreadyInUse {
                        self.delegate?.signalError(error: .alreadyUsed)
                        return
                    }
                }
                self.delegate?.login()
            }
        }
    }
    
    private func checkEmail(_ email: String) -> Bool {
        if email == "" {
            delegate?.signalError(error: RegisterError.noEmail)
            return false
        }
        return true
    }
    
    private func checkTerms(_ accepted: Bool) -> Bool {
        if !accepted {
            delegate?.signalError(error: RegisterError.termsNot)
            return false
        }
        return true
    }
    
    private func checkPasswords(_ password: String, _ confirmPassword: String) -> Bool {
        if password == "" {
            delegate?.signalError(error: RegisterError.noPassword)
            return false
        }
        else if confirmPassword == "" {
            delegate?.signalError(error: RegisterError.noPassword)
            return false
        }
        else if password.count <= 4 {
            delegate?.signalError(error: RegisterError.passwordShort)
            return false
        }
        else if password != confirmPassword {
            delegate?.signalError(error: RegisterError.noMatch)
            return false
        }
        return true
    }
}
