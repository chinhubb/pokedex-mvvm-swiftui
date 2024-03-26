//
//  PokemonDetailsView.swift
//  pokedex-mvvm-swiftui
//
//  Created by Jirawat on 26/3/2567 BE.
//

import SwiftUI

struct PokemonDetailsView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.pokemon.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            Text(viewModel.pokemon.name.capitalized)
                .font(.title)
            
            // ... Other details ...
        }
        .navigationTitle(viewModel.pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
