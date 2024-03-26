//
//  Pokemon.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let stats: [PokemonStat]
    
    var hp: Int {
        stats.first { $0.stat.name == "hp" }?.base_stat ?? 0
    }
    
    var attack: Int {
        stats.first { $0.stat.name == "attack" }?.base_stat ?? 0
    }
    
    var defense: Int {
        stats.first { $0.stat.name == "defense" }?.base_stat ?? 0
    }
    
    var specialAttack: Int {
        stats.first { $0.stat.name == "special-attack" }?.base_stat ?? 0
    }
    
    var specialDefense: Int {
        stats.first { $0.stat.name == "special-defense" }?.base_stat ?? 0
    }
    
    var speed: Int {
        stats.first { $0.stat.name == "speed" }?.base_stat ?? 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, sprites, stats
        case front_default
    }
    
    // Update init from decoder for nested structure
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        imageUrl = try spritesContainer.decode(String.self, forKey: .front_default)
        stats = try container.decode([PokemonStat].self, forKey: .stats)
    }
}

struct PokemonStat: Decodable {
    let base_stat: Int?
    let effort: Int
    let stat: NamedAPIResource
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}
