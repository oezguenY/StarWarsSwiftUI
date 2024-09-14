//
//  Endpoint.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation

struct Endpoint {
    static func charactersFromPage(_ pageNumber: Int) -> URL? {
        URL(string: "https://swapi.dev/api/people/?page=\(pageNumber)")
    }
    
    static func characterImage(characterName: String) -> URL? {
        let encodedName = characterName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://starwars-databank-server.vercel.app/api/v1/characters/name/\(encodedName)")
    }
    
    private init() {}
}

enum ApiError: Error {
    case invalidData
    case invalidResponse
    case invalidUrl
    case notFound
    case unsuccessfullResponse
}
