//
//  CharactersView.swift
//  RMWiki
//
//  Created by Alexandre Lellouche on 07/10/2022.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject private var viewModel = CharactersViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomColor.mainColor.ignoresSafeArea()
                VStack {
                    Image("rick_and_morty_logo")
                        .resizable()
                        .frame(height: 200)
                        .listRowBackground(Color.clear)
                    List {
                        MainCharactersSectionView(familyCharacters: self.viewModel.familyCharacters)
                        OtherCharactersSectionView(otherCharacters: self.searchResults)
                    }
                    .searchable(text: $searchText)
                    .scrollContentBackground(.hidden)
                }.onAppear() {
                    self.viewModel.fetchCharacters()
                }
            }
        }
    }
    
    var searchResults: [Character] {
            if searchText.isEmpty {
                return self.viewModel.otherCharacters
            } else {
                return self.viewModel.otherCharacters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
}

struct MainCharactersSectionView: View {
    let familyCharacters: [Character]
    
    var body: some View {
        Section {
            ForEach(self.familyCharacters) { character in
                NavigationLink {
                    let detailViewModel = CharacterDetailViewModel(character: character)
                    CharacterDetailView(viewModel: detailViewModel)
                } label: {
                    Text(character.name)
                }
            }
        } header: {
            Text("Main characters")
        }
    }
}

struct OtherCharactersSectionView: View {
    let otherCharacters: [Character]
    var body: some View {
        Section {
            ForEach(otherCharacters) { character in
                NavigationLink {
                    let detailViewModel = CharacterDetailViewModel(character: character)
                    CharacterDetailView(viewModel: detailViewModel)
                } label: {
                    Text(character.name)
                }
            }
        } header: {
            Text("Other characters")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
