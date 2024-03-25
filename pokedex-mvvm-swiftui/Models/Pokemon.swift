//
//  Pokemon.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let sprites: Sprites
    let types: [PokemonType]
}

struct Sprites: Decodable {
    let frontDefault: String?
}

struct PokemonType: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

