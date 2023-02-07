//
//  GetCharacters.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 07.02.2023.
//

import Foundation

struct RSGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RSCharacter]
}

