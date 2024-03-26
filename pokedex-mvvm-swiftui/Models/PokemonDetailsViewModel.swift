//
//  PokemonDetailsViewModel.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import Foundation
import Combine

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var isBookmarked: Bool = false
    @Published var isLoading = false
    @Published var error: Error? = nil
    
    private let bookmarkManager: BookmarkManager
    private var subscriptions = Set<AnyCancellable>()
    
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
    
    func getPokemonStats() {
        isLoading = true
        error = nil
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)"
        guard let url = URL(string: urlString) else {
            error = URLError(.badURL)
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] updatedPokemon in
                self?.pokemon.stats = updatedPokemon.stats
                print("sdfsf",self?.pokemon.hp)
            })
            .store(in: &subscriptions)
    }
}
