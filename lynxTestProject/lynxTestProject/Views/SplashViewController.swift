//
//  ViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import UIKit
import RxSwift
import RxRelay

class SplashViewController: UIViewController, LoginDelegate {
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    private var nextViewControllerId: String!
    private let items = BehaviorRelay<[Workout]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkIfUserLoggedIn()
        }
    }
    
    private func checkIfUserLoggedIn() {
        let defaults = UserDefaults.standard
        if let email = defaults.string(forKey: "email"), email != "",
           let password = defaults.string(forKey: "password"), password != "" {
            nextViewControllerId = ViewControllers.splash.rawValue
            let loginManager = LoginManager()
            loginManager.delegate = self
            loginManager.login(email: email, password: password)
            return
        }
        performSegue(withIdentifier: ViewControllers.splashToLogin.rawValue, sender: self)
    }
    
    func login(id: String) {
        loadData(with: id)
    }
    
    func signalError(_ error: LoginError) {
        performSegue(withIdentifier: ViewControllers.splashToLogin.rawValue, sender: self)
    }
    
    private func loadData(with id: String) {
            FirebaseManager.shared.getData(for: id, completion: { workouts in
                self.items.accept(workouts)
                self.performSegue(withIdentifier: self.nextViewControllerId, sender: self)
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? HistoryViewController else { return }
        controller.items.accept(items.value)
    }
}

