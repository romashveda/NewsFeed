//
//  CacheManager.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class ImageManager {
    
    private static let basicImageWidth: CGFloat = 250
    
    static func getImage(_ imageName: String, for url: URL, _ completion: ((_: UIImage?) -> ())?) {
        if let image = CacheManager.shared.get(for: imageName) {
            completion?(image)
            return
        }
        ImageManager.downloadImage(imageName, from: url) { image in
            completion?(image)
        }
    }
    
    private static func downloadImage(_ imageName: String, from url: URL, _ completion: ((_: UIImage?) -> ())?) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data), let resizedImage = image.resized(to: basicImageWidth) else { return }
                CacheManager.shared.save(image: resizedImage, stringURL: imageName)
                completion?(image)
            }
        }
    }
}

final class CacheManager {

    private let imageCache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    var countLimit = 50 {
        didSet {
            imageCache.countLimit = countLimit
        }
    }
    var memoryLimit = 50 {
        didSet {
            imageCache.totalCostLimit = memoryLimit * 1024 * 1024
        }
    }
    
    static let shared = CacheManager()
    
    private init() {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil, using: { [weak self] _ in
            self?.imageCache.removeAllObjects()
        })
        imageCache.countLimit = 50
        imageCache.totalCostLimit = 50 * 1024 * 1024
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func save(image: UIImage, stringURL: String) {
        imageCache.setObject(image, forKey: NSString(string: stringURL))
    }
    
    func get(for stringURL: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: stringURL))
    }
}
