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
            self.cameraButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.presentViewController(with: ViewControllers.camera.rawValue)
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var galleryButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton! {
        didSet {
            self.saveButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.save()
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    
    private func save() {
        guard let name = nameTextField.text, let calories = caloriesTextField.text,
              let duration = durationTextField.text else { return }
        let date = dateOfWorkoutDatePicker.date
        let workout = Workout(name: name, date: date, burnedCalories: calories, duration: duration, imageURL: "")
        let success = FirestoreManager.shared.upload(workout: workout)
        switch success {
        case .error(let err):
            signalError(err)
        default:
            return
        }
    }
    
    func signalError(_ error: String) {
        print(error)
        let alert = UIAlertController(title: "Attention", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
