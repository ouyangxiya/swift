//
//  ContentView.swift
//  Sandwiches
//
//  Created by Xiya Ouyang on 2022-11-16.
//

import SwiftUI
// https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita
struct ContentView: View {
    @StateObject private var viewModel = CocktailListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.cocktails, id: \.idDrink) { cocktail in
                Text(cocktail.strDrink)
            }
        }.onAppear{
            viewModel.getCocktails()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
