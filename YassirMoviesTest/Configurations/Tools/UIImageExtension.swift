//
//  UIImageExtension.swift
//  YassirMoviesTest
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    public func loadImageUsingCache(withUrl urlString : String, placeholder: String, completion: @escaping (UIImage?) -> Void) {
        image = placeholder.isEmpty ? nil : UIImage(named: placeholder)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            image = cachedImage
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            image = UIImage(named: placeholder)
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: placeholder)
                    completion(self.image)
                    return
                }
            }
            
            DispatchQueue.main.async {
                if data != nil {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                        completion(image)
                    }
                    else {
                        self.image = UIImage(named: placeholder)
                        completion(self.image)
                    }
                }
                else {
                    self.image = UIImage(named: placeholder)
                    completion(self.image)
                }
            }
            
        }).resume()
    }
}
