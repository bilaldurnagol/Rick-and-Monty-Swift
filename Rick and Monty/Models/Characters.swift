//
//  Characters.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import Foundation

struct Characters: Codable {
    let results: [Character]
}

struct Character: Codable {
    let created: String
    let episode: [String]
    let gender: String
    let id: Int
    let image: String
    let name: String
    let species: String
    let status: String
}
