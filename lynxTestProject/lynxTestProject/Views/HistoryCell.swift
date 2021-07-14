//
//  HistoryCell.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit

class HistoryCell: UITableViewCell {
    struct Constants {
        static let cellID = "historyCellID"
    }
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var workoutDateLabel: UILabel!
    @IBOutlet weak var workoutImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Constants.cellID)
    }
    
    func setup(with viewModel: WorkoutCellViewModel) {
        workoutNameLabel.text = viewModel.name
        workoutImageView.downloaded(from: viewModel.image)
    }
}
