//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - fetchData
    func fetchData(from url: String?, completion: @escaping(RickAndMorty) -> Void) {
        guard let stringUrl = url else { return }
        guard let url = URL(string: stringUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Some error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let characters = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(characters)
                }
            } catch let jsonError {
                print("Failed to decode JSON!", jsonError)
            }
        }.resume()
    }
    
    // MARK: - fetchEpisode
    func fetchEpisode(from url: String, completion: @escaping (Episode) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Some error: \(error?.localizedDescription ?? "No description")")
                return
            }
            
            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    completion(episode)
                }
            } catch let jsonError {
                print("Failed to decode JSON!", jsonError)
            }
        }.resume()
    }
    
    // MARK: - fetchCharacter
    func fetchCharacter(from url: String, completion: @escaping (Result) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Some error: \(error?.localizedDescription ?? "No description")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let jsonError {
                print("Failed to decode JSON!", jsonError)
            }
        }.resume()
    }
}

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print("Some error: \(error?.localizedDescription ?? "No description")")
                return
            }
            
            guard url == response.url else { return }
            
            completion(data, response)
        }.resume()
    }
    
}
