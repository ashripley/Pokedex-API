//
//  ContentView.swift
//  Pokedex API
//
//  Created by Ash Bronca on 30/9/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
        if searchText == "" { return pokemonVM.pokemon }
        return pokemonVM.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPokemon) { poke in
                    NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(poke.name.capitalized)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                    if poke.isFavourite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                HStack {
                                    Text(poke.type.capitalized)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    
                                    Circle()
                                        .foregroundColor(poke.typeColor)
                                        .frame(width: 10, height: 10)
                                }
                                Text(poke.description)
                                    .font(.caption)
                                    .lineLimit(4)
                            }
                            
                            Spacer()
                            
                            KFImage(URL(string: poke.imageURL))
                                .interpolation(.none)
                                .resizable()
                                .padding()
                                .frame(width: 100, height: 100)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1).padding(.all, -3))
                                .padding(.vertical)
                                .shadow(radius: 5)
                                .padding(10)
                                .background().clipShape(Circle())
                                .shadow(color: poke.typeColor, radius: 5, x: 0.0, y: 0.0)
                            
                            
                            
                            
                            
                            //                    AsyncImage(url: URL(string: poke.imageURL)) {phase in
                            //                        switch phase {
                            //                        case .empty:
                            //                            ProgressView()
                            //                        case .success(let image):
                            //                            image.resizable()
                            //                                .interpolation(.none)
                            //                                .scaledToFit()
                            //                                .frame(width: 100, height: 100)
                            //                        case .failure:
                            //                            Image(systemName: "photo")
                            //                        @unknown default:
                            //                            EmptyView()
                            //                        }
                            //                    }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: {
                            addFavourite(pokemon: poke)}) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                    }
                }
            }
            .navigationTitle("Pokedex API")
            .searchable(text: $searchText)
        }
    }
    
    func addFavourite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: {
            $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isFavourite.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
