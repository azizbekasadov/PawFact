//
//  API.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Foundation

fileprivate let url: String = "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs"

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case badRequest // 400
    case unknownError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Unable to detect url"
        case .badRequest:
            return "400 - Bad Request"
        case .unknownError:
            return "Unknown Error"
        }
    }
}

protocol API {
    associatedtype T: Decodable
    
    func request() async throws -> T?
}

final class APIImpl: API {
    func request() async throws -> [Fact]? {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        return try JSONDecoder().decode([Fact].self, from: data)
    }
    
    func fetchRandomFact() async throws -> Fact? {
        return try await request()?.first
    }
}
