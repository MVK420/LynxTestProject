//
//  WorkoutCellViewModel.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation

struct WorkoutCellViewModel {
    let name: String
    
    init(_ workout: Workout) {
        name = workout.name
    }
}
