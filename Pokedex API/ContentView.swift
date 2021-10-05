//
//  ContentView.swift
//  Pokedex API
//
//  Created by Ash Bronca on 30/9/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    var pokemonModel = PokemonModel()
    @State private var pokemon = [Pokemon]()
    
    var body: some View {
        NavigationView {
            List(pokemon) { poke in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(poke.name.capitalized)
                            .font(.title2)
                            .fontWeight(.medium)
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
            .navigationTitle("Pokedex API")
        }
        .onAppear {
            async {
                pokemon = try! await pokemonModel.getPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
