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

class LoginViewController: UIViewController {
    
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
    @IBOutlet weak var registerButton: UIButton!
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func onPressedLoginButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "History")
        self.present(viewController, animated: true, completion: nil)
    }
}
