//
//  PersonModel.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation

struct CharactersModels: Codable {
    let results: [CharacterModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct CharacterModel: Codable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let species: [String]
}
