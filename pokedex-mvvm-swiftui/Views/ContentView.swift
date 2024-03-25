//
//  ContentView.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 25/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonListViewModel()

    var body: some View {
        PokemonListView()
    }
}
