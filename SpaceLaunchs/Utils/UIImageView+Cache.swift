//
//  UIImageView+Cache.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
   
    fileprivate var placeHolder: UIImage? {
        UIImage(named: "placeholder")
    }
    fileprivate var fallbackImage: UIImage? {
        UIImage(named: "noimage")
    }
    func loadImage(_ URLString: String?) {
        self.image = nil
        guard let URLString = URLString else {
            DispatchQueue.main.async {
                self.image = self.fallbackImage
            }
            return
        }
        // Use the cached image if there is one
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        // Use placeholder when waiting for image loading
        self.image = placeHolder
        // Load image asynchronously using urlString and use fallback if failed to load
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.image = self.fallbackImage
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = self.fallbackImage
                    }
                }
            }).resume()
        } else {
            self.image = fallbackImage
        }
    }
}
