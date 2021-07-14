//
//  LoginViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, LoginDelegate {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            self.loginButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.onPressedLoginButton()
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            self.registerButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.performSegue(withIdentifier: ViewControllers.loginToRegister.rawValue, sender: self)
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    private let loginManager: LoginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginManager.delegate = self
    }

    private func onPressedLoginButton() {
        if let email = nameTextField.text, let password = passwordTextField.text {
            loginManager.login(email: email, password: password)
        }
    }
    
    func login() {
        performSegue(withIdentifier: ViewControllers.login.rawValue, sender: self)
    }
    
    func signalError(_ error: LoginError) {
        print(error)
        let alert = UIAlertController(title: "Attention", message: error.rawValue, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
