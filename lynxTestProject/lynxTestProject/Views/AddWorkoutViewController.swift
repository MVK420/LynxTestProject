//
//  AddWorkout.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddWorkoutViewController: BaseViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var caloriesTextField: UITextField!
    @IBOutlet private weak var workoutImageView: UIImageView!
    @IBOutlet private weak var dateOfWorkoutDatePicker: UIDatePicker!
    @IBOutlet private weak var durationTextField: UITextField!
    @IBOutlet private weak var cameraButton: UIButton! {
        didSet {
            self.cameraButton.rx.tap.bind {
                self.presentViewController(with: ViewControllers.camera.rawValue)
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var galleryButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    private let disposeBag: DisposeBag = DisposeBag()
}
