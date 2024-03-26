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
    
    private enum CodingKeys: String, CodingKey {
        case id, name, sprites
        case front_default
    }

    // Update init from decoder for nested structure
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        imageUrl = try spritesContainer.decode(String.self, forKey: .front_default)
    }
}
