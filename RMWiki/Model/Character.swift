//
//  Character.swift
//  RMWiki
//
//  Created by Alexandre Lellouche on 05/10/2022.
//

import Foundation

struct CharactersData: Codable {
    let results: [Character]
    let info: APIInfo
}

struct APIInfo: Codable {
    let next: String?
}

struct Character: Codable, Identifiable {
    var id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let origin: Origin
    let location: Location
}

struct Origin: Codable {
    let name: String
}

struct Location: Codable {
    let name: String
}
