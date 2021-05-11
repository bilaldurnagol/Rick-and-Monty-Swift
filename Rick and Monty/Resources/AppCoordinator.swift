//
//  AppCoordinator.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 11.05.2021.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = CharacterDetailsViewController()
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.rootViewController?.view.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
    }
}
