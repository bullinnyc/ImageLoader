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
    
    private var isSpin: Bool!
    private var spinSize: Int!
    private var spinType: SpinnerType!
    
    // MARK: - Public Methods
    func loadImage(from url: String, isSpin: Bool = false, spinSize: Int = 20, spinType: SpinnerType = .spinner, completion: (() -> Void)? = nil) {
        self.isSpin = isSpin
        self.spinSize = spinSize
        self.spinType = spinType
        
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
        setSpinner(isStart: true)
        
        // Get image from URL
        NetworkManager.shared.fetchImageData(from: url) { [unowned self] result in
            switch result {
            case .success(let data):
                let uiImage = self.getImageFromData(from: data)
                self.image = uiImage
                self.cache[url] = uiImage
                self.setSpinner()
                print("Image loaded from URL")
                
                guard let completion = completion else { return }
                completion()
            case .failure(let error):
                print(error.rawValue)
                
                DispatchQueue.main.async {
                    self.image = UIImage(systemName: "xmark.icloud.fill")
                    self.setSpinner()
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
    
    private func setSpinner(isStart: Bool = false) {
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
        default:
            break
        }
    }
}

