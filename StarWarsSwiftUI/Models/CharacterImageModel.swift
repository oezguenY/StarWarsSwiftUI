//
//  PersonImageModel.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation

struct CharacterImageModels: Codable {
    let results: [CharacterImageModel]
}

struct CharacterImageModel: Codable {
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image"
    }
}
