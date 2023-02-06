//
//  RSCharacterStatus.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

enum RSCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "Unknown"
}
