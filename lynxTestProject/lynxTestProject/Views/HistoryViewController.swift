//
//  HistoryViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/9/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: BaseViewController {
    
    @IBOutlet private weak var workoutTableView: UITableView!
    @IBOutlet private weak var addWorkoutButton: UIButton! {
        didSet {
            addWorkoutButton.rx.tap.bind{ [weak self] in
                guard let self = self else { return }
                self.presentViewController(with: ViewControllers.addWorkout.rawValue)
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    let items = BehaviorRelay<[Workout]>(value: [Workout(name: "Alma", date: Date(timeIntervalSinceNow: 1), burnedCalories: "200", duration: "60", imageURL: "")])
    
    private func bindTableView() {
        items.bind(to: self.workoutTableView.rx.items(cellIdentifier: HistoryCell.Constants.cellID, cellType: HistoryCell.self)) { (tv, item, cell) in
            let viewModel = WorkoutCellViewModel(item)
            cell.setup(with: viewModel)
        }.disposed(by: disposeBag)
    }
}
