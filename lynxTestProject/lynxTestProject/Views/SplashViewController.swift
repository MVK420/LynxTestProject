//
//  ViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import UIKit

class SplashViewController: BaseViewController, LoginDelegate {
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        checkIfUserLoggedIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.finishedLoading()
        }
    }
    
    private func loadData() { }
    private func finishedLoading() {
        let viewControllerID = checkIfUserLoggedIn() ? "Login": "Register"
        presentViewController(with: viewControllerID)
    }
    
    private func checkIfUserLoggedIn() -> Bool {
        let defaults = UserDefaults.standard
        if let email = defaults.string(forKey: "email"), email != "",
           let password = defaults.string(forKey: "password"), password != "" {
            let loginManager = LoginManager()
            loginManager.delegate = self
            loginManager.login(email: email, password: password)
        }
        return true
    }
    
    func login() {
        presentViewController(with: ViewControllers.history.rawValue)
    }
    
    func signalError(_ error: LoginError) {
        return
    }
}

