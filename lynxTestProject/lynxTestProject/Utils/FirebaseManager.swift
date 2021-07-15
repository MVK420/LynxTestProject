//
//  FirestoreManager.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation

import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

enum FirebaseSuccess {
    case success
    case error(String)
}

enum FirebaseError: String {
    case noData = "Please enter some data"
}

class FirebaseManager {
    
    static let shared: FirebaseManager = FirebaseManager()
    private init() { }
    
    func upload(workout: Workout) -> FirebaseSuccess {
        if validate(workout) {
            Firestore.firestore().collection("Workouts").document("\(UUID())").setData(workout.dictionary, merge: true)
            
            return FirebaseSuccess.success
        }
        return FirebaseSuccess.error(FirebaseError.noData.rawValue)
    }
    
    private func validate(_ workout: Workout) -> Bool {
        return !(workout.name == "" && workout.burnedCalories == "" && workout.imageURL == "" && workout.duration == "")
    }
    
    func uploadImage(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
        var data = NSData()
        data = image.jpegData(compressionQuality: 0.8)! as NSData
        let storageRef = Storage.storage().reference().child("\(UUID())")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            else {
                //store downloadURL
                storageRef.downloadURL { (url, error) in
                  guard let downloadURL = url else { return }
                    completion(downloadURL.absoluteString)
                }
            }
        }
    }

    func getData(for user: String, completion: @escaping([Workout]) -> Void) {
            Firestore.firestore().collection("Workouts").whereField("userID", isEqualTo: User.uid).getDocuments() { snapshot, err in
                var result: [Workout] = [Workout]()
                snapshot!.documents.map {
                    if let data = self.decode($0.data()) {
                        result.append(data)
                    }
                }
                completion(result)
            }
    }
    
    private func decode(_ data: [String: Any]) -> Workout? {
        if let name = data["name"] as? String, let date = data["date"], let burnedClories = data["burnedCalories"] as? String, let duration = data["duration"] as? String, let url = data["imageURL"]  as? String {
            
            let workout = Workout(name: name, date: Date(timeIntervalSinceReferenceDate: date as! TimeInterval), burnedCalories: burnedClories, duration: duration, imageURL: url)
            print(workout)
            return workout
        }
        return nil
    }
}

