//
//  ImageDownloader.swift
//  Image Search
//
//  Created by Alex Paul on 2/26/22.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloadImage(_ imgURL: String, placeholder: UIImage? = nil)  {
        guard let url = URL(string: imgURL) else { return  }
        if let imageToCache = imageCache.object(forKey: imgURL as NSString) {
            image = imageToCache
            return
        }
        image = placeholder
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
           let imageToCache = UIImage(data: data)
            else {
                print(error ?? URLError(.badServerResponse))
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(imageToCache, forKey: imgURL as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        
    }
}
