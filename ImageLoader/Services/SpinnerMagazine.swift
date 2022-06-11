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
    case multicolorSpinner
}

class SpinnerMagazine {
    // MARK: - Private Properties
    private var activityIndicator: UIActivityIndicatorView!
    private var spinner: UIImageView!
    private var multicolorSpinner: MulticolorSpinnerView!
    
    // MARK: - Public Methods
    func startActivityIndicator(in view: UIView, style: UIActivityIndicatorView.Style) {
        activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        setupConstraints(subView: activityIndicator, parentView: view)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func setupConstraints(subView: UIView, parentView: UIView, size: CGFloat? = nil) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: size ?? .zero),
            subView.widthAnchor.constraint(equalToConstant: size ?? .zero),
            subView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
    }
}

// MARK: - Ext. Spinner from resources
extension SpinnerMagazine {
    func startSpinner(in view: UIView, size: CGFloat) {
        guard let image = UIImage(named: "spinner") else { return }
        let templateImage = image.withRenderingMode(.alwaysTemplate)
        
        spinner = UIImageView(image: templateImage)
        spinner.frame = CGRect(x: 0, y: 0, width: size, height: size)
        spinner.tintColor = .systemBlue // Your color
        
        view.addSubview(spinner)
        view.subviews.forEach { subView in
            guard subView.isDescendant(of: spinner) else { return }
            
            let rotation = animateRotation(duration: 0.5)
            subView.layer.add(rotation, forKey: "spinAnimation")
            setupConstraints(subView: spinner, parentView: view, size: size)
        }
    }
    
    func stopSpinner(in view: UIView) {
        view.subviews.forEach { subView in
            guard subView.isDescendant(of: spinner) else { return }
            
            subView.layer.removeAnimation(forKey: "spinAnimation")
            subView.removeFromSuperview()
        }
    }
    
    private func animateRotation(duration: Double) -> CABasicAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = duration
        rotation.repeatCount = .infinity
        return rotation
    }
}

// MARK: - Ext. Multicolor spinner
extension SpinnerMagazine {
    func startMulticolorSpinner(in view: UIView, size: CGFloat) {
        multicolorSpinner = MulticolorSpinnerView(
            colors: [.red, .systemGreen, .systemBlue], // Your colors
            lineWidth: CGFloat(size) * 0.10
        )
        
        multicolorSpinner.frame = CGRect(x: 0, y: 0, width: size, height: size)
        multicolorSpinner.isAnimating = true
        
        view.addSubview(multicolorSpinner)
        setupConstraints(subView: multicolorSpinner, parentView: view, size: size)
    }
    
    func stopMulticolorSpinner() {
        multicolorSpinner.isAnimating = false
    }
}
