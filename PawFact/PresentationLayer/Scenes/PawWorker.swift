//
//  PawWorker.swift
//  PawFact
//
//  Created by Azizbek Asadov on 08/03/23.
//

import Foundation

protocol PawWorkerProtocol {
    func loadFact(completion: (Result<Fact, Error>) async -> Void) async
}

struct PawWorker {
    private let apiService: (any API)
    
    init(apiService: (any API)) {
        self.apiService = apiService
    }
    
    func loadFact(completion: (Result<Fact, Error>) async -> Void) async {
        guard let api = apiService as? APIImpl else {
            await completion(.failure(NetworkError.unknownError))
            return
        }
        
        do {
            guard let fact = try await api.fetchRandomFact() else {
                throw NetworkError.unknownError
            }
            
            await completion(.success(fact))
        } catch {
            print(error.localizedDescription)
            await completion(.failure(error))
        }
    }
}
