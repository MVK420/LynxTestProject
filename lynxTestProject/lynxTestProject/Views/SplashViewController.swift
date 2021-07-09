//
//  ViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.finishedLoading()
        }
        // Do any additional setup after loading the view.
    }
    
    private func loadData() { }
    private func finishedLoading() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerID = checkIfUserLoggedIn() ? "Login": "Register"
        let viewController = storyboard.instantiateViewController(identifier: viewControllerID)
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func checkIfUserLoggedIn() -> Bool {
        return true
    }
}

