//
//  TemporaryImageCache.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import UIKit

class TemporaryImageCache {
    // MARK: - Public Properties
    static let shared = TemporaryImageCache()

    // MARK: - Private Properties
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // 100 items
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()

    // MARK: - Private Initializers
    private init() {}

    // MARK: - Subscripts
    subscript(_ key: String) -> UIImage? {
        get { cache.object(forKey: NSString(string: key)) }
        set {
            newValue == nil
            ? cache.removeObject(forKey: NSString(string: key))
            : cache.setObject((newValue ?? UIImage()), forKey: NSString(string: key))
        }
    }
}

