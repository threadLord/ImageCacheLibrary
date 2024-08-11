//
//  File.swift
//  
//
//  Created by Marko on 5.8.24..
//


import UIKit

@available(iOS 15, *)
public class ImageCache {
    static public let shared = ImageCache()
    private var cache = CacheDisk<Data>()
    private let cacheQueue = DispatchQueue(label: "cacheQueue", qos: .userInteractive)
    
    public func change(cache: CacheDisk<Data>) {
        self.cache = cache
    }

    public func loadImage(url: URL, key: String, completion: @escaping (UIImage?) -> Void) {
        cacheQueue.async {
            if let cachedData = self.cache.value(forKey: key)?.value {
                DispatchQueue.main.async {
                    completion(UIImage(data: cachedData))
                }
            } else {
                self.downloadImage(url: url, key: key, completion: completion)
            }
        }
    }

    private func downloadImage(url: URL, key: String, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
                        
            let _ = self.cache.save(data, forKey: key)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    public func deleteCache(with keys: [String]) {
        cacheQueue.async {
            keys.forEach{  let _ = self.cache.deleteFromDisk(forKey:$0)}
        }
    }
}
