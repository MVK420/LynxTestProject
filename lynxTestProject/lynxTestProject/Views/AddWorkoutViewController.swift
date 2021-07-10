//
//  AddWorkout.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation
import UIKit

class AddWorkoutViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var caloriesTextField: UITextField!
    @IBOutlet private weak var workoutImageView: UIImageView!
    @IBOutlet private weak var dateOfWorkoutDatePicker: UIDatePicker!
    @IBOutlet private weak var durationTextField: UITextField!
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var galleryButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
}
