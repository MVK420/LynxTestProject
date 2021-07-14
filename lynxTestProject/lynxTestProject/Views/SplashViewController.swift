//
//  ViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import UIKit

class SplashViewController: UIViewController, LoginDelegate {
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    var nextViewControllerId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkIfUserLoggedIn()
        }
    }
    
    private func loadData() { }
    
    private func checkIfUserLoggedIn() {
        let defaults = UserDefaults.standard
        if let email = defaults.string(forKey: "email"), email != "",
           let password = defaults.string(forKey: "password"), password != "" {
            nextViewControllerId = ViewControllers.splashToLogin.rawValue
            let loginManager = LoginManager()
            loginManager.delegate = self
            loginManager.login(email: email, password: password)
        }
        nextViewControllerId = ViewControllers.splash.rawValue
    }
    
    func login() {
        performSegue(withIdentifier: nextViewControllerId, sender: self)
    }
    
    func signalError(_ error: LoginError) {
        return
    }
}

