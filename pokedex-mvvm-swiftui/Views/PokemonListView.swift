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
       List {
           ForEach(viewModel.pokemonList) { pokemon in
               PokemonRow(pokemon: pokemon)
           }
       }
       .overlay(
           ProgressView()
               .opacity(viewModel.isLoading ? 1 : 0)
       )
    }
}

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        Text("\(pokemon.name)")
    }
}
