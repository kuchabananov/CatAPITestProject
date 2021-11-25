//
//  Image.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import Foundation

struct Image: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
    }
    
    var id: String?
    var url: String?

}
