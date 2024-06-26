//
//  PokemonListView.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import SwiftUI

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    @StateObject var bookmarkManager = BookmarkManager()

    var body: some View {
        NavigationView {
            List(viewModel.pokemonList) { pokemon in
                NavigationLink(destination: PokemonDetailsView(
                            viewModel: PokemonDetailsViewModel(pokemon: pokemon, bookmarkManager: bookmarkManager))) {
                    Text(pokemon.name.capitalized)
                }
            }
            .navigationTitle("Pokemon List")
        }
    }
}
