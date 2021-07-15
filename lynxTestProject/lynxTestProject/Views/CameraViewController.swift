//
//  CameraViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation
import UIKit
import RxSwift

class CameraViewController: UIViewController {
    @IBOutlet private weak var captureButton: UIButton! {
        didSet {
            self.captureButton.setupUI()
            captureButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.onClickCaptureButton()
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var cameraImageView: UIImageView!
    private var frameExtractor: FrameExtractor!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frameExtractor = FrameExtractor()
        self.frameExtractor.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        frameExtractor.stop()
    }
    
    private func onClickCaptureButton() {
        let index = navigationController?.viewControllers.firstIndex(of: self)
        let previousViewController = navigationController?.viewControllers[index!-1]
        if let addViewController = previousViewController as? AddWorkoutViewController {
            addViewController.workoutImageView.image = cameraImageView.image
        }
        navigationController?.popViewController(animated: true)
    }
}

extension CameraViewController: FrameExtractorDelegate {
    func captured(image: UIImage) {
        cameraImageView.image = image
    }
}
