//
//  CocktailAPIService.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-12-09.
//

import Foundation
import UIKit

class CocktailAPIService {
    static let shared = CocktailAPIService()
    static let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
    
    func getCocktailList() async throws -> Drinks? {
        guard let url = URL(string: CocktailAPIService.urlString) else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 else {
            throw URLError(.badServerResponse)
        }
        
        let drinks = try JSONDecoder().decode(Drinks.self, from: data)
        return drinks
    }
    
    func downloadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let request = URLRequest.init(url:url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        return  UIImage(data: data)
    }
}
