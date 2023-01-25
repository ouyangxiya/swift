//
//  Cocktail.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-12-09.
//

import Foundation

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
}

struct Drinks: Codable {
    let drinks: [Cocktail]
}
