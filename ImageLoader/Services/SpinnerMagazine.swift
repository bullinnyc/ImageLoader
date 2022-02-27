//
//  SpinnerMagazine.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import UIKit

enum SpinnerType {
    case activityIndicatorLarge
    case activityIndicatorMedium
    case spinner
}

class SpinnerMagazine {
    // MARK: - Private Properties
    private var spinner: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Methods
    func startSpinner(in view: UIView, size: Int) {
        spinner = getSpinner(size: size)
        spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(spinner)
        view.subviews.forEach { subView in
            guard view.subviews.contains(spinner) else { return }
            subView.layer.add(animateSpinner(duration: 0.5), forKey: "spinAnimation")
        }
    }
    
    func stopSpinner(in view: UIView) {
        view.subviews.forEach { subView in
            guard view.subviews.contains(spinner) else { return }
            subView.layer.removeAnimation(forKey: "spinAnimation")
            subView.removeFromSuperview()
        }
    }
    
    func startActivityIndicator(in view: UIView, style: UIActivityIndicatorView.Style) {
        activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func getSpinner(size: Int) -> UIImageView {
        let image = UIImageView(image: UIImage(named: "spinner"))
        image.frame = CGRect(x: 0, y: 0, width: size, height: size)
        return image
    }
    
    private func animateSpinner(duration: Double) -> CABasicAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = duration
        rotation.repeatCount = .infinity
        return rotation
    }
}
