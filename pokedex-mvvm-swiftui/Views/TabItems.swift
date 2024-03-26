//
//  TabItems.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import SwiftUI

struct PokemonListTabItem: View {
    var body: some View {
        VStack {
            Image(systemName: "list.bullet")
            Text("Pokemon List")
        }
    }
}

struct BookmarkedListTabItem: View {
    var body: some View {
        VStack {
            Image(systemName: "bookmark.fill")
            Text("Bookmarks")
        }
    }
}

