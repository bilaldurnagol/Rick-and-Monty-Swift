//
//  CharacterListViewModel.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import Foundation


struct CharacterListViewModel {
    let characters: [Character]
}

extension CharacterListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.characters.count
    }
    
    func characterAtIndex(_ index: Int) -> CharacterViewModel {
        let character = self.characters[index]
        return CharacterViewModel(character)
    }
}

struct CharacterViewModel {
    private let character: Character
}

extension CharacterViewModel {
    init(_ character: Character) {
        self.character = character
    }
}

extension CharacterViewModel {
    
    var id: Int {
        return self.character.id
    }
    
    var name: String {
        return self.character.name
    }
    
    var imageURL: String {
        return self.character.image
    }
    
    var status: String {
        return self.character.status
    }
    
    var species: String {
        return self.character.species
    }
    
    var gender: String {
        return self.character.gender
    }
    var episode: [String] {
        return self.character.episode
    }
    
}

