//
//  Workout.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

struct Workout: Codable {
    let name: String
    let date: Date
    let burnedCalories: String
    let duration: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case date
        case burnedCalories
        case duration
        case imageURL
    }
}

struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
