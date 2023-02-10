//
//  RSCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 10.02.2023.
//

import Foundation

final class RSCharacterDetailViewViewModel {
    private let character: RSCharacter
    
    init(character: RSCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
