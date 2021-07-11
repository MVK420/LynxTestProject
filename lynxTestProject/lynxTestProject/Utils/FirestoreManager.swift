//
//  FirestoreManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

enum FirebaseSuccess {
    case success
    case error(String)
}

enum FirebaseError: String {
    case noData = "Please enter some data"
}

class FirestoreManager {
    
    static let shared: FirestoreManager = FirestoreManager()
    private init() { }
    
    func upload(workout: Workout) -> FirebaseSuccess {
        if validate(workout) {
            Firestore.firestore().collection("Workouts").document(User.uid).setData(workout.dictionary)
            return FirebaseSuccess.success
        }
        return FirebaseSuccess.error(FirebaseError.noData.rawValue)
    }
    
    private func validate(_ workout: Workout) -> Bool {
        return !(workout.name == "" && workout.burnedCalories == "" && workout.imageURL == "" && workout.duration == "")
    }
}

