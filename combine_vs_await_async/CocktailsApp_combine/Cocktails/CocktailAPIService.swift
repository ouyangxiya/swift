//
//  CocktailAPIService.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-12-09.
//

import Foundation
import Combine

class CocktailAPIService {
    static let shared = CocktailAPIService()
    
    func getCocktailList() -> AnyPublisher<Drinks, Error>? {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap{ (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }.decode(type: Drinks.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }
}
