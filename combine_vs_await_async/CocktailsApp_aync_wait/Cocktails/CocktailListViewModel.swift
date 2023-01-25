//
//  CocktailListViewModel.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-12-09.
//

import Foundation
import Combine
import UIKit

@MainActor
class CocktailListViewModel: ObservableObject {
    @Published var cocktails: [CocktailViewModel] = []
    @Published var isRequestFailed = false

    func getCocktails() { 
        Task {
            do {
                let list = try await CocktailAPIService.shared.getCocktailList()
                guard let drinks = list?.drinks else { return }
                self.cocktails  = drinks.map({ cocktail in
                    CocktailViewModel(cocktail: cocktail)
                })
            } catch {
                print("Request fail with error: \(error)")
                isRequestFailed = true
            }
        }
    }
}

@MainActor
class CocktailViewModel: ObservableObject  {
    @Published var idString: String
    @Published var cocktail: Cocktail
    @Published var thumbnail: UIImage?
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        self.idString = cocktail.idDrink
        
        // download
        Task {
            do {
                thumbnail = try await CocktailAPIService.shared.downloadImage(from: cocktail.strDrinkThumb )
            } catch {
                print("Download image fail with error: \(error)")
            }
        }
    }
}
