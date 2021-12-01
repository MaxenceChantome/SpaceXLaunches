//
//  ImageLoader.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private let networkingLoader = ImageNetworkingLoader()
    private var currentRequests = [UIImageView: UUID]()
    
    func load(_ url: URL, for imageView: UIImageView) {
        let uuid = networkingLoader.loadImage(url) { result in
            
            defer { self.currentRequests.removeValue(forKey: imageView) }
            
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                imageView.setPlaceholder()
            }
        }
        
        if let uuid = uuid {
            currentRequests[imageView] = uuid
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = currentRequests[imageView] {
            networkingLoader.cancelLoad(uuid)
            currentRequests.removeValue(forKey: imageView)
        }
    }
}


fileprivate class ImageNetworkingLoader {
    private let cache = NSCache<NSString, UIImage>()
    private var currentRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.currentRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(.success(image))
                return
            }
            
            if let error = error, (error as NSError).code != NSURLErrorCancelled {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        currentRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        currentRequests[uuid]?.cancel()
        currentRequests.removeValue(forKey: uuid)
    }
}
