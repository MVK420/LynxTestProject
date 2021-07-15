//
//  UIButton.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/15/21.
//

import Foundation
import UIKit

extension UIButton {
    func setupUI() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.tintColor = .black
    }
}
