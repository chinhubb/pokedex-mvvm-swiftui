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

    var body: some View {
        NavigationView {
                List(viewModel.pokemonList) { pokemon in
                    NavigationLink(destination: PokemonDetailsView( viewModel: PokemonDetailsViewModel(pokemon: pokemon))) {
                        Text(pokemon.name.capitalized)
                    }
                }
                .navigationTitle("Pokemon List")
            }
        }
}

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        Text("\(pokemon.name)")
    }
}
