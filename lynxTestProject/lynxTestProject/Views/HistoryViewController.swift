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

class HistoryViewController: UIViewController {
    
    @IBOutlet private weak var workoutTableView: UITableView!
    @IBOutlet private weak var addWorkoutButton: UIButton! {
        didSet {
            self.addWorkoutButton.setupUI()
            addWorkoutButton.rx.tap.bind{ [weak self] in
                guard let self = self else { return }

                self.performSegue(withIdentifier: ViewControllers.addWorkout.rawValue, sender: self)
            }.disposed(by: disposeBag)
        }
    }
    private let disposeBag: DisposeBag = DisposeBag()
    private var selectedWorkout: Workout!
    let items = BehaviorRelay<[Workout]>(value: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func bindTableView() {
        items.bind(to: self.workoutTableView.rx.items(cellIdentifier: HistoryCell.Constants.cellID, cellType: HistoryCell.self)) { (tv, item, cell) in
            let viewModel = WorkoutCellViewModel(item)
            cell.setup(with: viewModel)
        }.disposed(by: disposeBag)
        
        workoutTableView.rx.modelSelected(Workout.self)
            .subscribe(onNext: { [weak self] tappedWorkout in
                guard let self = self else { return }
                self.selectedWorkout = tappedWorkout
                self.performSegue(withIdentifier: "toDetailSegue", sender: self)
                // Deselect row
                if let selectedRowIndexPath = self.workoutTableView.indexPathForSelectedRow {
                    self.workoutTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    private func loadData() {
            FirebaseManager.shared.getData(for: User.uid, completion: { workouts in
                self.items.accept(workouts)
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailViewController else { return }
        controller.model = self.selectedWorkout
    }
}
