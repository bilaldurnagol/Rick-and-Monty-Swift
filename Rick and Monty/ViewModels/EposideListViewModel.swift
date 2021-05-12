//
//  EposideViewModel.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 12.05.2021.
//

import Foundation

struct EposideListViewModel {
    let eposides: [Eposide]
}

extension EposideListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.eposides.count
    }
    
    func characterAtIndex(_ index: Int) -> EposideViewModel {
        let eposide = self.eposides[index]
        return EposideViewModel(eposide)
    }
}

struct EposideViewModel {
    private let eposide: Eposide
}

extension EposideViewModel {
    init(_ eposide: Eposide) {
        self.eposide = eposide
    }
}

extension EposideViewModel {
    var id: Int {
        return self.eposide.id
    }
    var eposideName: String {
        return "\(self.eposide.name) \(self.eposide.episode)"
    }
}
