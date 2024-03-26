//
//  PokemonDetailsViewModel.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import Foundation

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var isBookmarked: Bool = false

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
