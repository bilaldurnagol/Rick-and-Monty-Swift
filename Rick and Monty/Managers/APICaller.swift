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
    
    struct Constants {
         static let baseAPIURL = "https://rickandmortyapi.com/api"
     }
    
    func getCharacters(completion: @escaping ((Result<[Character], Error>) -> Void)) {
        guard let url = URL(string: Constants.baseAPIURL+"/character") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetCharacters))
                return
            }
            do {
                let characters = try JSONDecoder().decode(Characters.self, from: data)
                completion(.success(characters.results))
            }catch {
                completion(.failure(error))
            } 
        }).resume()
    }
    
    func getCharacterDetails(with id: Int?, completion: @escaping ((Result<Character, Error>) -> Void)) {
        guard let id = id, let url = URL(string: Constants.baseAPIURL+"/character/\(id)") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetCharacters))
                return
            }
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(character))
            }catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getEposide(with eposideURLs: [String]?, completion: @escaping ([Eposide]) -> Void) {
        
        let idsString = eposideIDS(with: eposideURLs)
        guard let url = URL(string: Constants.baseAPIURL+"/episode/\(idsString),") else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let eposides = try JSONDecoder().decode([Eposide].self, from: data)
                completion(eposides)
            }catch {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    // eposide url to eposide id converter
    func eposideIDS(with eposideURLs: [String]?) -> String {
        guard let eposideURLs = eposideURLs else {return ""}
        var modifiedIDs = [String]()
        for eposideURL in eposideURLs {
            modifiedIDs.append(eposideURL.lastPath!)
        }
        let ids = modifiedIDs.joined(separator: ",")
        return ids
    }
}
