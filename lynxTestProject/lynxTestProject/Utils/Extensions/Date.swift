//
//  Date.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/15/21.
//

import Foundation


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        return dateFormatter.string(from: self)
    }
}
