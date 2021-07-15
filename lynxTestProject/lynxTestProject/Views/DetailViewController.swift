//
//  DetailViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/14/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var workoutImageView: UIImageView!
    
    var viewModel: DetailViewModel!
    var model: Workout! {
        didSet {
            viewModel = DetailViewModel(from: model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        caloriesLabel.text = viewModel.calories
        durationLabel.text = viewModel.duration
        workoutImageView.downloaded(from: viewModel.imageURL)
    }
}
