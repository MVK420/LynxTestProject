//
//  DetailViewModel.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/14/21.
//

import Foundation

struct DetailViewModel {
    let name: String
    let date: String
    let calories: String
    let duration: String
    let imageURL: String
    
    init(from model: Workout) {
        name = model.name
        date = model.date.toString()
        calories = model.burnedCalories
        duration = model.duration
        imageURL = model.imageURL
    }
}
