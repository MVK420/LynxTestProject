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

class LoginViewController: BaseViewController {
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
                self.presentViewController(with: "Register")
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()

    private func onPressedLoginButton() {
        self.presentViewController(with: "History")
    }
}
