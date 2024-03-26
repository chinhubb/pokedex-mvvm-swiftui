//
//  BookmarkManager.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import Foundation

class BookmarkManager: ObservableObject {
    @Published var bookmarkedPokemonIds: [Int] = []
    private let userDefaultsKey = "bookmarkedPokemonIds"
    
    enum BookmarkError: Error {
        case saveError
        case loadError
    }
    
    init() {
        loadBookmarks()
    }
    
    func addBookmark(pokemonId: Int) -> Result<Void, BookmarkError> {
        if !bookmarkedPokemonIds.contains(pokemonId) {
            bookmarkedPokemonIds.append(pokemonId)
            return saveBookmarks() ? .success(()) : .failure(.saveError)
        } else {
            return .success(())
        }
    }
    
    func removeBookmark(pokemonId: Int) -> Result<Void, BookmarkError> {
        bookmarkedPokemonIds.removeAll(where: {$0 == pokemonId})
        return saveBookmarks() ? .success(()) : .failure(.saveError)
    }
    
    func loadBookmarks() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decodedIds = try? JSONDecoder().decode([Int].self, from: data) {
                bookmarkedPokemonIds = decodedIds
                return
            }
        }
    }
    
    func saveBookmarks() -> Bool {
        if let encodedData = try? JSONEncoder().encode(bookmarkedPokemonIds) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
            return true
        }
        return false
    }
}
