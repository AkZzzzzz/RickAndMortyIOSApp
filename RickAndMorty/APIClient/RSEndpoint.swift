//
//  RSEndpoint.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

@frozen enum RSEndpoint: String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
