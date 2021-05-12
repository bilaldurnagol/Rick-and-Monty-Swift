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
    
    func getCharacterDetails(with id: Int, completion: @escaping ((Result<ResultResponse, Error>) -> Void)) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetCharacters))
                return
            }
            do {
                let character = try JSONDecoder().decode(ResultResponse.self, from: data)
                completion(.success(character))
            }catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getEposide(with id: String?, completion: @escaping (String) -> Void) {
//        let myString = id.joined(separator: ",")
//        print(String(myString))
        guard let id = id else {return}
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(id)") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let eposide = try JSONDecoder().decode(Eposide.self, from: data)
                completion("\(eposide.name) (\(eposide.episode))")
            }catch {
             
            }
        }).resume()
    }
}
