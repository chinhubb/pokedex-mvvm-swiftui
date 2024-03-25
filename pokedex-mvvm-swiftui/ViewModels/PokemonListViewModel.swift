//
//  PokemonListViewModel.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading: Bool = false
    
    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        fetchPokemon()
    }
    
    func fetchPokemon() {
        print("Fetching Pokemon...") // Did this get called?
        isLoading = true
        apiService.fetchPokemonList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error occurred: \(error)")
                case .finished:
                    print("Fetch completed")
                }
            }, receiveValue: { [weak self] pokemon in
                self?.pokemonList = pokemon
                print("Received Pokemon:", pokemon) // Inspect what was received
            })
            .store(in: &cancellables)
    }
}
