//
//  RSCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 18.02.2023.
//

import Foundation

final class RSCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
