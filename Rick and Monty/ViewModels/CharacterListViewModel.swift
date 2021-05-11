//
//  CharacterListViewModel.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import Foundation

class CharacterListViewModel {
    
    private var characterViewModels = [ResultResponse]()
    
    func numberOfRows(_ section: Int) -> Int {
        return characterViewModels.count
    }
    
    func modelAt(_ index: Int) -> ResultResponse {
        return characterViewModels[index]
    }
}

//class WeatherListViewModel {
//
//    private var weatherViewModels = [WeatherViewModel]()
//
//    func addWeatherViewModel(_ vm: WeatherViewModel) {
//        weatherViewModels.append(vm)
//    }
//
//    func numberOfRows(_ section: Int) -> Int {
//        return weatherViewModels.count
//    }
//
//    func modelAt(_ index: Int) -> WeatherViewModel {
//        return weatherViewModels[index]
//    }
//}
