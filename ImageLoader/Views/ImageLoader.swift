//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import UIKit

class ImageLoader: UIImageView {
    // MARK: - Private Properties
    private let cache = TemporaryImageCache.shared
    private let spinner = SpinnerMagazine()
    
    // MARK: - Public Methods
    func loadImage(from url: String, isSpin: Bool = false, spinSize: CGFloat = 20, spinType: SpinnerType = .multicolorSpinner, completion: (() -> Void)? = nil) {
        // Check image to cache
        if let cachedImage = cache[url] {
            image = cachedImage
            print("Image from cache")
            
            guard let completion = completion else { return }
            
            completion()
            return
        } else {
            image = UIImage()
        }
        
        // Show spinner
        setSpinner(isStart: true, isSpin: isSpin, spinSize: spinSize, spinType: spinType)
        
        // Get image from URL
        NetworkManager.shared.fetchImageData(from: url) { [unowned self] result in
            switch result {
            case .success(let data):
                let uiImage = self.getImageFromData(from: data)
                self.image = uiImage
                self.cache[url] = uiImage
                self.setSpinner(isSpin: isSpin, spinSize: spinSize, spinType: spinType)
                print("Image loaded from URL")
                
                guard let completion = completion else { return }
                completion()
            case .failure(let error):
                print(error.rawValue)
                
                DispatchQueue.main.async {
                    self.image = UIImage(systemName: "xmark.icloud.fill")
                    self.setSpinner(isSpin: isSpin, spinSize: spinSize, spinType: spinType)
                    print("Image from resources")
                    
                    guard let completion = completion else { return }
                    completion()
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func getImageFromData(from data: Data?) -> UIImage {
        guard let data = data, let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    private func setSpinner(isStart: Bool = false, isSpin: Bool, spinSize: CGFloat, spinType: SpinnerType) {
        guard isSpin else { return }
        
        switch spinType {
        case .activityIndicatorLarge:
            isStart
            ? spinner.startActivityIndicator(in: self, style: .large)
            : spinner.stopActivityIndicator()
        case .activityIndicatorMedium:
            isStart
            ? spinner.startActivityIndicator(in: self, style: .medium)
            : spinner.stopActivityIndicator()
        case .spinner:
            isStart
            ? spinner.startSpinner(in: self, size: spinSize)
            : spinner.stopSpinner(in: self)
        case .multicolorSpinner:
            isStart
            ? spinner.startMulticolorSpinner(in: self, size: spinSize)
            : spinner.stopMulticolorSpinner()
        }
    }
}
