//
//  APICaller.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    
    enum APIError: Error {
        case failedToGetCharacters
    }
    func getCharacters(completion: @escaping ((Result<Characters, Error>) -> Void)) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetCharacters))
                return
            }
            do {
                let characters = try JSONDecoder().decode(Characters.self, from: data)
                completion(.success(characters))
            }catch {
                completion(.failure(error))
            } 
        }).resume()
    }
}
