//
//  RegisterViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: BaseViewController, RegisterDelegate {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            self.signupButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.onPressedSignupButton()
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    private let registerManager: RegisterManager = RegisterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerManager.delegate = self
    }
    
    func login() {
        presentViewController(with: ViewControllers.history.rawValue)
    }
    
    func signalError(error: RegisterError) {
        print(error)
        let alert = UIAlertController(title: "Attention", message: error.rawValue, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func onPressedSignupButton() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text else { return }
        registerManager.validateData(email: email, password: password, confirmPassword: confirm, termsAccepted: termsSwitch.isOn)
    }
}
