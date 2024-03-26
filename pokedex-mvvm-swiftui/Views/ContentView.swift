//
//  ContentView.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    @StateObject var bookmarkManager = BookmarkManager()
    
    var body: some View {
        TabView {
            PokemonListView(viewModel: viewModel, bookmarkManager: bookmarkManager)
                .tabItem {
                    PokemonListTabItem()
                }
            
            NavigationView {
                BookmarkedPokemonListView(bookmarkManager: bookmarkManager)
            }
            .tabItem { 
                BookmarkedListTabItem()
            }
        }
    }
}
