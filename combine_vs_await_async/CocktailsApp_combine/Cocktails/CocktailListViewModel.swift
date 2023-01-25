//
//  CocktailListViewModel.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-12-09.
//

import Foundation
import Combine

class CocktailListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var isRequestFailed = false
    
    private var cancellable: AnyCancellable?
        
    func getCocktails() {
        cancellable = CocktailAPIService.shared.getCocktailList()?
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isRequestFailed = true
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { cocktails in
                self.cocktails.append(contentsOf: cocktails.drinks )
            }
    }
}
