//
//  CameraViewController.swift
//  lynxTestProject
//
//  Created by Mozes Vidami on 7/10/21.
//

import Foundation
import UIKit

class CameraViewController: UIViewController {
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var cameraImageView: UIImageView!
    private var frameExtractor: FrameExtractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frameExtractor = FrameExtractor()
        self.frameExtractor.delegate = self
    }
}

extension CameraViewController: FrameExtractorDelegate {
    func captured(image: UIImage) {
        cameraImageView.image = image
    }
}
