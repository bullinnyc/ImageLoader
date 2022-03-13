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
        spinner = UIImageView(image: UIImage(named: "spinner"))
        spinner.frame = CGRect(x: 0, y: 0, width: size, height: size)
        spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        animateRotation(duration: 0.5)
        view.addSubview(spinner)
        
        setupConstraints(subView: spinner, parentView: view, size: size)
    }
    
    func stopSpinner(in view: UIView) {
        view.subviews.forEach { subView in
            guard view.subviews.contains(spinner) else { return }
            subView.layer.removeAnimation(forKey: "spinAnimation")
            subView.removeFromSuperview()
        }
    }
    
    private func animateRotation(duration: Double) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = duration
        rotation.repeatCount = .infinity
        spinner.layer.add(rotation, forKey: "spinAnimation")
    }
}

// MARK: - Ext. Multicolor spinner
extension SpinnerMagazine {
    func startMulticolorSpinner(in view: UIView, size: CGFloat) {
        multicolorSpinner = MulticolorSpinnerView(
            colors: [.red, .systemGreen, .systemBlue],
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
