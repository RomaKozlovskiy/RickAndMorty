//
//  RickAndMorty.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Result]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Result: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Origin: \(origin)
    Location: \(location.name)
    """
    }
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let date: String
    let episode: String
    let characters: [String]
    
    var description: String {
        """
    Episode: \(name)
    Date: \(date)
    """
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}

enum URLS: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}
