//
//  RegisterManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

enum RegisterError: String {
    case noEmail = "Please enter your email"
    case noPassword = "Please enter your password"
    case noCofirmPassword = "Please confirm your password"
    case noMatch = "Your passwords don't match"
    case alreadyUsed = "This email is already registered"
    case passwordShort = "This password is too short"
}

protocol RegisterDelegate {
    func signalError(error: RegisterError)
}

class RegisterManager {
    var delegate: RegisterDelegate?
    
    func validateData(email: String, password: String, confirmPassword: String) -> Bool {
        return checkEmail(email) &&
            checkPasswords(password, confirmPassword)
    }
    
    private func checkEmail(_ email: String) -> Bool {
        if email == "" {
            delegate?.signalError(error: RegisterError.noEmail)
            return false
        }
        else if checkEmailInDb(email) {
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
    
    private func checkEmailInDb(_ email: String) -> Bool {
        return false
    }
}
