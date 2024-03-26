//
//  APIService.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import Combine
import Foundation

protocol APIServiceProtocol {
    func fetchPokemonList() -> AnyPublisher<[Pokemon], Error>
    func fetchPokemonDetails(url: URL) -> AnyPublisher<Pokemon, Error>
}

class APIService: APIServiceProtocol {
    
    func fetchPokemonList() -> AnyPublisher<[Pokemon], Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonListResults.self, decoder: JSONDecoder())
            .flatMap { results -> Publishers.Collect<Publishers.FlatMap<AnyPublisher<Pokemon, Error>, Publishers.SetFailureType<Publishers.Sequence<[PokemonListItem], Never>, Error>>> in
                results.results.publisher
                    .flatMap { item -> AnyPublisher<Pokemon, Error> in
                        let detailURL = URL(string: item.url)!
                        return self.fetchPokemonDetails(url: detailURL)
                    }
                    .collect()
            }            .eraseToAnyPublisher()
    }
    
    func fetchPokemonDetails(url: URL) -> AnyPublisher<Pokemon, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
