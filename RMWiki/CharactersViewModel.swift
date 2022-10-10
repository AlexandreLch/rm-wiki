//
//  CharactersViewModel.swift
//  RMWiki
//
//  Created by Alexandre Lellouche on 07/10/2022.
//

import Foundation
import Combine

final class CharactersViewModel: ObservableObject {
    @Published var familyCharacters: [Character] = []
    @Published var otherCharacters: [Character] = []
    
    private var familyCharactersBuffer: [Character] = []
    private var otherCharactersBuffer: [Character] = []
    
    private var nextURLString: String? = nil
    private var bag = Set<AnyCancellable>()
    
    func fetchCharacters(from urlString: String = "https://rickandmortyapi.com/api/character/?page=") {
        if let url = URL(string: urlString) {
            URLSession.shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: CharactersData.self, decoder: JSONDecoder())
                .sink { res in
                    switch res {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        guard let url = self.nextURLString else {
                            self.familyCharacters = self.familyCharactersBuffer
                            self.otherCharacters = self.otherCharactersBuffer
                            self.familyCharactersBuffer = []
                            self.otherCharactersBuffer = []
                            return
                        }
                        self.fetchCharacters(from: url)
                    }
                } receiveValue: { characters in
                    characters.results.forEach { character in
                        if character.id < 6 {
                            self.familyCharactersBuffer.append(character)
                        } else {
                            self.otherCharactersBuffer.append(character)
                        }
                    }
                    self.nextURLString = characters.info.next
                }
                .store(in: &bag)
        }
    }
}
