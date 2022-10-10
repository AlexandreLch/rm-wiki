//
//  CharacterDetailView.swift
//  RMWiki
//
//  Created by Alexandre Lellouche on 07/10/2022.
//

import Foundation
import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var type: String {
        if viewModel.character.type.isEmpty {
            return "None"
        }
        return viewModel.character.type
    }
    
    var body: some View {
        ZStack {
            CustomColor.mainColor.ignoresSafeArea()
            VStack {
                Text(viewModel.character.name)
                    .font(.title)
                    .fontWeight(.bold)
                AsyncImage(url: URL(string: viewModel.character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                } placeholder: {
                    //
                }
                List {
                    Text("Status: \(viewModel.character.status)")
                    Text("Species: \(viewModel.character.species)")
                    Text("Subspecies: \(self.type)")
                    Text("Gender: \(viewModel.character.gender)")
                    Text("Origin: \(viewModel.character.origin.name)")
                    Text("Location: \(viewModel.character.location.name)")
                    
                    Section {
                        ForEach(self.viewModel.episodesNumber, id: \.self) { episodeNumber in
                            Text("Episode \(episodeNumber)")
                        }
                    } header: {
                        Text("Appears in")
                    }
                }.scrollContentBackground(.hidden)
            }
        }
    }
}
