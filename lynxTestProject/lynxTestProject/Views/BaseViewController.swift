//
//  BaseViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    func presentViewController(with id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id)
        self.present(viewController, animated: true, completion: nil)
    }
}
