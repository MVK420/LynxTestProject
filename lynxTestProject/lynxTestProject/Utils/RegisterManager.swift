//
//  RegisterManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

enum RegisterErrors: String {
    case noEmail = "Please enter your email"
    case noPassword = "Please enter your password"
}

protocol RegisterDelegate {
    func signalError(error: String)
}

class RegisterManager {
    var delegate: RegisterDelegate?
    
    func validateData(email: String, password: String, confirmPassword: String) {
        checkEmail(email)
        checkPasswords(password, confirmPassword)
    }
    
    private func checkEmail(_ email: String) {
        if email == "" {
            delegate?.signalError(error: RegisterErrors.noEmail.rawValue)
            return
        }
    }
    
    private func checkPasswords(_ password: String, _ confirmPassword: String) {
        if password == "" || confirmPassword == "" {
            delegate?.signalError(error: RegisterErrors.noPassword.rawValue)
            return
        }
    }
}
