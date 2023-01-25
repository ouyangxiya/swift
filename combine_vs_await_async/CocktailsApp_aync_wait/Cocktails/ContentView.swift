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
        NavigationView {
            List {
                ForEach(viewModel.cocktails, id: \.idString) { viewModel in
                    ListRow(viewModel: viewModel)
                }
            }.onAppear{
                viewModel.getCocktails()
            }.navigationTitle("Content View")
                .alert("Request Failed", isPresented: $viewModel.isRequestFailed) {
                    Button("OK", role: .cancel) { }
                }
        }
    }
}

struct ListRow: View {
    @ObservedObject var viewModel: CocktailViewModel
    var body: some View {
        NavigationLink(destination: Text("Second View")) {
            HStack(alignment: .bottom) {
                Image(uiImage: viewModel.thumbnail ?? UIImage()).resizable().frame(width: 50.0, height: 50.0)
                Text(viewModel.cocktail.strDrink)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
