//
//  String+Extensions.swift
//  Rick and Monty
//
//  Created by Bilal Durnagöl on 12.05.2021.
//

import UIKit

extension String {
    var lastPath: String? {
        let urlArray = self.components(separatedBy: "/")
        let lastPath = urlArray.last
        return lastPath
    }
}
