//
//  ViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/8/21.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
        return true
    }
}

