//
//  Character.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

struct RSCharacter: Codable {
    let id: Int
    let name: String
    let status: RSCharacterStatus
    let species: String
    let type: String
    let gender: RSCharacterGender
    let origin: RSOrigin
    let location: RSSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
