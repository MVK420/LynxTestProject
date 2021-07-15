//
//  WorkoutCellViewModel.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

struct WorkoutCellViewModel {
    let name: String
    let image: String
    let date: String
    
    init(_ workout: Workout) {
        name = workout.name
        image = workout.imageURL
        date = workout.date.toString()
    }
}
