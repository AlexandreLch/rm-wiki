//
//  CharacterDetailViewModel.swift
//  RMWiki
//
//  Created by Alexandre Lellouche on 07/10/2022.
//

import Foundation
import Combine

final class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character
    @Published var episodesNumber: [String]
    
    init(character: Character) {
        self.character = character
        self.episodesNumber = CharacterDetailViewModel.generateEpisodesArray(from: character)
    }
    
    static private func generateEpisodesArray(from character: Character) -> [String] {
        var episodesNumber: [String] = []
        character.episode.forEach {
            let episodeNumber = $0.components(separatedBy: "/").last
            if let number = episodeNumber {
                episodesNumber.append(number)
            }
        }
        return episodesNumber
    }
}
