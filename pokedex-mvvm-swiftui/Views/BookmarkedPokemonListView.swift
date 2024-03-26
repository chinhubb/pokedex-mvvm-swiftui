//
//  BookmarkedPokemonListView.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import SwiftUI

struct BookmarkedPokemonListView: View {
    @ObservedObject var bookmarkManager: BookmarkManager
    @ObservedObject var pokemonListViewModel = PokemonListViewModel()
    
    var body: some View {
        List {
            ForEach(getBookmarkedPokemon()) { pokemon in
                NavigationLink(destination: PokemonDetailsView(viewModel: PokemonDetailsViewModel(pokemon: pokemon, bookmarkManager: bookmarkManager))) {
                    BookmarkRowView(pokemon: pokemon)
                }
            }
        }
        .navigationTitle("Bookmarked Pokemon")
        .onAppear {
            bookmarkManager.loadBookmarks()
        }
    }
    
    func getBookmarkedPokemon() -> [Pokemon] {
        return pokemonListViewModel.pokemonList.filter { pokemon in
            bookmarkManager.bookmarkedPokemonIds.contains(pokemon.id)
        }
    }
}

struct BookmarkRowView: View {
    let pokemon: Pokemon

    var body: some View {
        Text(pokemon.name.capitalized)
    }
}
