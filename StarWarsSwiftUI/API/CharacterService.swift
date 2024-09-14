//
//  PersonService.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation

struct CharacterService {
    func fetchCharactersFromPage(_ pageNumber: Int) async throws -> [CharacterModel] {
        guard let endpointUrl = Endpoint.charactersFromPage(pageNumber) else {
            throw ApiError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: endpointUrl)
        
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        guard response.statusCode != 404 else {
            throw ApiError.notFound
        }
        guard response.statusCode == 200 else {
            throw ApiError.unsuccessfullResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(CharactersModels.self, from: data).results
        } catch {
            throw ApiError.invalidData
        }
    }
}
