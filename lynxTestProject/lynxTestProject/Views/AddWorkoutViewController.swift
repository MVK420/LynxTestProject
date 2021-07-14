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

class AddWorkoutViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
    @IBOutlet private weak var galleryButton: UIButton! {
        didSet {
            self.galleryButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.onClickGalleryButton()
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var saveButton: UIButton! {
        didSet {
            self.saveButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.save()
            }.disposed(by: disposeBag)
        }
    }
    private var imagePicker = UIImagePickerController()
    private let disposeBag: DisposeBag = DisposeBag()
    
    private func save() {
        guard let name = nameTextField.text, let calories = caloriesTextField.text,
              let duration = durationTextField.text else { return }
        let date = dateOfWorkoutDatePicker.date
        if let image = workoutImageView.image {
            FirebaseManager.shared.uploadImage(image: image, completion: { url in
                let workout = Workout(name: name, date: date, burnedCalories: calories, duration: duration, imageURL: url ?? "") // signal error here
                let success = FirebaseManager.shared.upload(workout: workout)
                switch success {
                case .error(let err):
                    self.signalError(err)
                default:
                    return
                }
            })
        }
        
    }
    
    func signalError(_ error: String) {
        print(error)
        let alert = UIAlertController(title: "Attention", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func onClickGalleryButton() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        workoutImageView.image = image
    }
}
