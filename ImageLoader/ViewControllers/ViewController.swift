//
//  ViewController.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var firstImageView: ImageLoader!
    @IBOutlet weak var secondImageView: ImageLoader!
    @IBOutlet weak var thirdImageView: ImageLoader!
    @IBOutlet weak var fourthImageView: ImageLoader!
    @IBOutlet weak var fifthImageView: ImageLoader!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        firstImageView.loadImage(
            from: "https://unsplash.com/photos/wOj5odhDOZ0/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQ1OTQ1OTM5&force=true&w=640", // 2400
            isSpin: true,
            spinType: .spinner
        )
        
        secondImageView.loadImage(
            from: "https://unsplash.com/photos/dnnBNxq51wg/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQ1OTMzMDQ0&force=true&w=2400", // 640
            isSpin: true
        )
        
        thirdImageView.loadImage(
            from: "https://unsplash.com/photos/ubSUwrr04Ks/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQ1OTQ0NDY3&force=true&w=2400", // 640
            isSpin: true,
            spinType: .activityIndicatorMedium
        )
    
        fourthImageView.loadImage(
            from: "https://unsplash.com/photos/YJ4hqRchpWE/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8Mjh8fG5ldyUyMHlvcmslMjBob3Jpem9udGFsfGVufDB8fHx8MTY0NTk0NTgzNA&force=true&w=640", // 2400
            isSpin: true,
            spinType: .activityIndicatorLarge
        )
        
        fifthImageView.loadImage(
            from: "https://unsplash.com/photos/s6L0uQyprpE/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQ1OTQ2ODQ3&force=true&w=640", // 2400
            isSpin: true
        )
    }
}
