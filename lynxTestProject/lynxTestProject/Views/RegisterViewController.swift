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

class RegisterViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmTextField: UITextField!
    @IBOutlet private weak var conditionsSwitch: UISwitch!
    @IBOutlet private weak var signupButton: UIButton! {
        didSet {
            self.signupButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.onPressedSignupButton()
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func onPressedSignupButton() {
        
    }
}
