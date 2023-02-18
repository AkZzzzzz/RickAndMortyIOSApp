//
//  RSCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 18.02.2023.
//

import Foundation

final class RSCharacterInfoCollectionViewCellViewModel {
    
    public let value: String
    public let title: String
    
    init(
        value: String,
        title: String
    ) {
        self.value = value
        self.title = title
    }
}
