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
    private let bookmarkManager: BookmarkManager

    init(pokemon: Pokemon, bookmarkManager: BookmarkManager) {
        self.pokemon = pokemon
        self.bookmarkManager = bookmarkManager
        self.isBookmarked = bookmarkManager.bookmarkedPokemonIds.contains(pokemon.id)
    }

    func toggleBookmark() {
        isBookmarked.toggle()

        switch bookmarkManager.bookmarkedPokemonIds.contains(pokemon.id) ?
                bookmarkManager.removeBookmark(pokemonId: pokemon.id) :
                bookmarkManager.addBookmark(pokemonId: pokemon.id) {
        case .success():
            print("Bookmark updated successfully")
        case .failure(let error):
            print("Bookmark update error: \(error)")
            isBookmarked.toggle()
        }
    }
}
