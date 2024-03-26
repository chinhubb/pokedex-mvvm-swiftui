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
        ScrollView {
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
                
                HStack {
                    Text("HP:")
                    Text("\(viewModel.pokemon.hp)")
                        .bold()
                }
                
                HStack {
                    Text("Attack:")
                    Text("\(viewModel.pokemon.attack)")
                        .bold()
                }
                
                HStack {
                    Text("Defense:")
                    Text("\(viewModel.pokemon.defense)")
                        .bold()
                }
                
                HStack {
                    Text("Special Attack:")
                    Text("\(viewModel.pokemon.specialAttack)")
                        .bold()
                }
                
                HStack {
                    Text("Special Defense:")
                    Text("\(viewModel.pokemon.specialDefense)")
                        .bold()
                }
                
                HStack {
                    Text("Speed:")
                    Text("\(viewModel.pokemon.speed)")
                        .bold()
                }
            }
        }
        .onAppear {
            viewModel.getPokemonStats()
        }
        .navigationTitle(viewModel.pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(viewModel.isBookmarked ? "Unbookmark" : "Bookmark") {
            viewModel.toggleBookmark()
        }
        )
    }
}
