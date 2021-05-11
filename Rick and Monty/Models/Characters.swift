//
//  Characters.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import Foundation

struct Characters: Codable {
    let results: [ResultResponse]
}

struct ResultResponse: Codable {
    let created: String
    let episode: [String]
    let gender: String
    let id: Int
    let image: String
    let name: String
    let species: String
    let status: String
}
//{
//    info =     {
//        count = 671;
//        next = "https://rickandmortyapi.com/api/character?page=2";
//        pages = 34;
//        prev = "<null>";
//    };
//    results =     (
//                {
//            created = "2017-11-04T18:48:46.250Z";
//            episode =             (
//                "https://rickandmortyapi.com/api/episode/1",
//                "https://rickandmortyapi.com/api/episode/2",
//                "https://rickandmortyapi.com/api/episode/39",
//                "https://rickandmortyapi.com/api/episode/40",
//                "https://rickandmortyapi.com/api/episode/41"
//            );
//            gender = Male;
//            id = 1;
//            image = "https://rickandmortyapi.com/api/character/avatar/1.jpeg";
//            location =             {
//                name = "Earth (Replacement Dimension)";
//                url = "https://rickandmortyapi.com/api/location/20";
//            };
//            name = "Rick Sanchez";
//            origin =             {
//                name = "Earth (C-137)";
//                url = "https://rickandmortyapi.com/api/location/1";
//            };
//            species = Human;
//            status = Alive;
//            type = "";
//            url = "https://rickandmortyapi.com/api/character/1";
//        }
