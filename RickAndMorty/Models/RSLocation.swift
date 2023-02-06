//
//  Location.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

struct RSLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
