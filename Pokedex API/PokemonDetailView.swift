//
//  PokemonDetailView.swift
//  Pokedex API
//
//  Created by Ash Bronca on 10/10/21.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    var pokemon:Pokemon
    @State private var scale: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    HStack {
                        Text(pokemon.type.capitalized)
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        Circle()
                            .foregroundColor(pokemon.typeColor)
                            .frame(width: 10, height: 10)
                    }
                    .padding(-20)
                    
                    KFImage(URL(string: pokemon.imageURL))
                        .interpolation(.none)
                        .resizable()
                        .padding()
                        .frame(width: 220, height: 220)
                        .padding(20)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1).padding(.all, -3))
                        .padding(.vertical)
                        .shadow(radius: 5)
                        .padding(10)
                        .background().clipShape(Circle())
                        .shadow(color: pokemon.typeColor, radius: 5, x: 0.0, y: 0.0)
                        .padding(.bottom, -160)
                        .zIndex(1)
                    
                    
                    ZStack {
                        Rectangle()
                            .edgesIgnoringSafeArea(.bottom)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .foregroundColor(pokemon.typeColor)
                        
                        VStack {
                            if pokemon.isFavourite {
                                Label("Favourite", systemImage: "star.fill")
                                    .foregroundColor(pokemon.typeColor)
                                    .padding(5)
                                    .background(Capsule().foregroundColor(.white))
                            }
                            
                            Text(pokemon.description.replacingOccurrences(of: "\n", with: ""))
                                .foregroundColor(.white)
                                .padding()
                                .padding(.top, 70)
                            
                            StatsViewGroup(pokemon: pokemon)
                        }
                        .offset(y: -40)
                        .scaleEffect(scale)
                        .onAppear {
                            let baseAnimation = Animation
                                .spring(dampingFraction: 0.5)
                            let repeated = baseAnimation.repeatCount(1)
                            
                            withAnimation(repeated) {
                                scale = 1
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
