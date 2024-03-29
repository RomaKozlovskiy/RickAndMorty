//
//  CharacterImageView.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class CharacterImageView: UIImageView {

    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
            return
        }

        ImageManager.shared.fetchImage(from: imageUrl) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            self.saveDataToCache(with: data, and: response)
        }
    }
      
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }

}
