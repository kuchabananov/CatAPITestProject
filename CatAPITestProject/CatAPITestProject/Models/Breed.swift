//
//  Breed.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import Foundation

struct Breed: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case lifeSpan = "life_span"
        case altNames = "alt_names"
        case wikipediaUrl = "wikipedia_url"
        case image
        case description
    }
    
    var id: String?
    var name: String?
    var temperament: String?
    var lifeSpan: String?
    var altNames: String?
    var wikipediaUrl: String?
    var image: Image?
    var description: String?
    
}
